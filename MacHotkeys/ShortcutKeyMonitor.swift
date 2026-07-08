import AppKit
import Combine
import SwiftUI

struct ComboChord: Equatable {
    let modifiers: NSEvent.ModifierFlags
    let keys: [String]
}

struct ParsedComboSequence {
    let shortcutID: String
    let single: ComboChord?
    let primary: ComboChord?
    let secondary: ComboChord?
    let primaryTokens: [String]
    let secondaryTokens: [String]
}

final class ShortcutKeyMonitor: ObservableObject {
    static let shared = ShortcutKeyMonitor()

    @Published private(set) var matchedShortcutID: String?
    @Published private(set) var partialShortcutID: String?
    @Published private(set) var pressedModifiers: NSEvent.ModifierFlags = []
    @Published private(set) var pressedKeys: Set<String> = []

    var highlightedShortcutID: String? { matchedShortcutID }

    var isSearchFieldFocused = false

    private weak var observedWindow: NSWindow?
    private var sequences: [ParsedComboSequence] = []
    private var keyDownMonitor: Any?
    private var keyUpMonitor: Any?
    private var flagsMonitor: Any?
    private var pendingSecondary: (id: String, expiry: Date)?
    private var fadeTask: Task<Void, Never>?
    private var partialExpiryTask: Task<Void, Never>?

    private let sequenceTimeout: TimeInterval = 2.5
    private let matchHoldDuration: TimeInterval = 2.0
    private let matchFadeDuration: TimeInterval = 0.26

    private static let deviceModifiers = NSEvent.ModifierFlags([.command, .shift, .option, .control, .function])
    private static let debug = false

    private init() {}

    func updateShortcuts(_ shortcuts: [Shortcut]) {
        sequences = shortcuts.map { Self.parseSequence(combo: $0.combo, id: $0.id) }
    }

    func ensureShortcutsLoaded() {
        guard sequences.isEmpty else { return }
        updateShortcuts(ShortcutsStore.load().shortcuts)
    }

    func setObservedWindow(_ window: NSWindow) {
        observedWindow = window
    }

    func start() {
        ensureShortcutsLoaded()
        installMonitorsIfNeeded()
    }

    func stop() {
        resetTransientState()
    }

    func clearPressedInput() {
        pressedModifiers = []
        pressedKeys = []
    }

    private func installMonitorsIfNeeded() {
        guard keyDownMonitor == nil, keyUpMonitor == nil, flagsMonitor == nil else { return }

        keyDownMonitor = NSEvent.addLocalMonitorForEvents(matching: .keyDown) { [weak self] event in
            guard let self else { return event }
            self.deliver { self.handleKeyDown(event) }
            return event
        }

        keyUpMonitor = NSEvent.addLocalMonitorForEvents(matching: .keyUp) { [weak self] event in
            guard let self else { return event }
            self.deliver { self.handleKeyUp(event) }
            return event
        }

        flagsMonitor = NSEvent.addLocalMonitorForEvents(matching: .flagsChanged) { [weak self] event in
            guard let self else { return event }
            self.deliver { self.handleFlagsChanged(event) }
            return event
        }

        if Self.debug {
            print("[ShortcutKeyMonitor] local monitors installed")
        }
    }

    private func deliver(_ work: () -> Void) {
        if Thread.isMainThread {
            work()
        } else {
            DispatchQueue.main.sync(execute: work)
        }
    }

    func isTokenPressed(token: String, shortcutID: String) -> Bool {
        guard shortcutID == matchedShortcutID || shortcutID == partialShortcutID else { return false }
        guard Self.tokenIsDown(token, modifiers: pressedModifiers, keys: pressedKeys) else { return false }
        guard let sequence = sequences.first(where: { $0.shortcutID == shortcutID }),
              let chord = currentChord() else { return false }

        if let single = sequence.single, chordsEqual(single, chord) {
            return tokenInTokens(token, sequence.primaryTokens)
        }
        if let primary = sequence.primary, chordsEqual(primary, chord) {
            return tokenInTokens(token, sequence.primaryTokens)
        }
        if let secondary = sequence.secondary, chordsEqual(secondary, chord) {
            return tokenInTokens(token, sequence.secondaryTokens)
        }
        return false
    }

    func hasActiveKeyboardMatch(for shortcutID: String) -> Bool {
        (matchedShortcutID == shortcutID || partialShortcutID == shortcutID)
            && (!pressedKeys.isEmpty || !normalizedModifiers(pressedModifiers).isEmpty)
    }

    private func tokenInTokens(_ token: String, _ tokens: [String]) -> Bool {
        tokens.contains { $0 == token || Self.normalizeKeyToken($0) == Self.normalizeKeyToken(token) }
    }

    private var isWindowActive: Bool {
        guard let keyWindow = NSApp.keyWindow else { return false }
        if let observedWindow {
            return keyWindow === observedWindow
        }
        return MenuBarController.shared.isKeyWindow
    }

    private func handleKeyDown(_ event: NSEvent) {
        if Self.debug {
            print(
                "KEY DOWN:",
                event.charactersIgnoringModifiers ?? "",
                event.modifierFlags,
                "searchFocused:", isSearchFieldFocused,
                "isKeyWindow:", isWindowActive
            )
        }
        guard isWindowActive else { return }
        guard !isSearchFieldFocused else { return }
        syncModifiers(from: event)
        if let key = Self.keyToken(from: event) {
            pressedKeys.insert(key)
        }
        fadeTask?.cancel()
        evaluateMatches()
        objectWillChange.send()
    }

    private func handleKeyUp(_ event: NSEvent) {
        if Self.debug {
            print(
                "KEY UP:",
                event.charactersIgnoringModifiers ?? "",
                event.modifierFlags,
                "searchFocused:", isSearchFieldFocused
            )
        }
        guard isWindowActive else { return }
        guard !isSearchFieldFocused else { return }
        if let key = Self.keyToken(from: event) {
            pressedKeys.remove(key)
        }
        syncModifiers(from: event)
        if isInputReleased {
            scheduleFadeAfterRelease()
        } else {
            evaluateMatches()
            objectWillChange.send()
        }
    }

    private func handleFlagsChanged(_ event: NSEvent) {
        guard isWindowActive else { return }
        guard !isSearchFieldFocused else { return }
        syncModifiers(from: event)
        if isInputReleased {
            scheduleFadeAfterRelease()
        } else {
            fadeTask?.cancel()
            evaluateMatches()
            objectWillChange.send()
        }
    }

    private var isInputReleased: Bool {
        pressedKeys.isEmpty && normalizedModifiers(pressedModifiers).isEmpty
    }

    private func normalizedModifiers(_ flags: NSEvent.ModifierFlags) -> NSEvent.ModifierFlags {
        flags.intersection(Self.deviceModifiers)
    }

    private func syncModifiers(from event: NSEvent) {
        pressedModifiers = normalizedModifiers(event.modifierFlags)
    }

    private func currentChord() -> ComboChord? {
        let mods = normalizedModifiers(pressedModifiers)
        guard !pressedKeys.isEmpty || !mods.isEmpty else { return nil }
        return ComboChord(modifiers: mods, keys: Array(pressedKeys).sorted())
    }

    private func displayTokens(for chord: ComboChord) -> [String] {
        var tokens: [String] = []
        if chord.modifiers.contains(.control) { tokens.append("⌃") }
        if chord.modifiers.contains(.option) { tokens.append("⌥") }
        if chord.modifiers.contains(.shift) { tokens.append("⇧") }
        if chord.modifiers.contains(.command) { tokens.append("⌘") }
        if chord.modifiers.contains(.function) { tokens.append("Fn") }
        for key in chord.keys {
            tokens.append(key.count == 1 ? key.uppercased() : Self.displayKeyToken(key))
        }
        return tokens
    }

    private static func displayKeyToken(_ key: String) -> String {
        switch key {
        case "space": "Space"
        case "tab": "Tab"
        case "esc": "Esc"
        case "delete": "Delete"
        default: key
        }
    }

    private func evaluateMatches() {
        guard let chord = currentChord() else { return }

        if Self.debug {
            print("NORMALIZED COMBO:", displayTokens(for: chord))
        }

        if let pending = pendingSecondary, Date() < pending.expiry,
           let sequence = sequences.first(where: { $0.shortcutID == pending.id }),
           let secondary = sequence.secondary,
           chordsEqual(secondary, chord) {
            matchedShortcutID = pending.id
            partialShortcutID = nil
            pendingSecondary = nil
            partialExpiryTask?.cancel()
            fadeTask?.cancel()
            debugMatch(id: pending.id)
            return
        }

        for sequence in sequences {
            if let single = sequence.single, chordsEqual(single, chord) {
                matchedShortcutID = sequence.shortcutID
                partialShortcutID = nil
                pendingSecondary = nil
                partialExpiryTask?.cancel()
                fadeTask?.cancel()
                debugMatch(id: sequence.shortcutID)
                return
            }
        }

        for sequence in sequences where sequence.secondary != nil {
            if let primary = sequence.primary, chordsEqual(primary, chord) {
                partialShortcutID = sequence.shortcutID
                matchedShortcutID = nil
                pendingSecondary = (sequence.shortcutID, Date().addingTimeInterval(sequenceTimeout))
                schedulePartialExpiry()
                fadeTask?.cancel()
                if Self.debug {
                    print("PARTIAL MATCH:", sequence.shortcutID)
                }
                return
            }
        }
    }

    private func debugMatch(id: String) {
        guard Self.debug else { return }
        if let shortcut = ShortcutsStore.load().shortcuts.first(where: { $0.id == id }) {
            print("MATCH:", shortcut.title, shortcut.id)
        }
        print("ACTIVE SHORTCUT:", id)
    }

    private func scheduleFadeAfterRelease() {
        guard matchedShortcutID != nil || partialShortcutID != nil else { return }
        fadeTask?.cancel()
        fadeTask = Task { @MainActor in
            try? await Task.sleep(nanoseconds: UInt64(matchHoldDuration * 1_000_000_000))
            guard !Task.isCancelled else { return }
            withAnimation(.easeInOut(duration: matchFadeDuration)) {
                matchedShortcutID = nil
                if pendingSecondary == nil || Date() >= (pendingSecondary?.expiry ?? .distantPast) {
                    partialShortcutID = nil
                }
            }
            if Self.debug {
                print("ACTIVE SHORTCUT: nil")
            }
        }
    }

    private func schedulePartialExpiry() {
        partialExpiryTask?.cancel()
        partialExpiryTask = Task { @MainActor in
            try? await Task.sleep(nanoseconds: UInt64(sequenceTimeout * 1_000_000_000))
            guard !Task.isCancelled else { return }
            if let pending = pendingSecondary, Date() >= pending.expiry {
                withAnimation(.easeInOut(duration: matchFadeDuration)) {
                    if partialShortcutID == pending.id, matchedShortcutID != pending.id {
                        partialShortcutID = nil
                    }
                    pendingSecondary = nil
                }
            }
        }
    }

    private func resetTransientState() {
        matchedShortcutID = nil
        partialShortcutID = nil
        pressedModifiers = []
        pressedKeys = []
        pendingSecondary = nil
        fadeTask?.cancel()
        partialExpiryTask?.cancel()
    }

    private func chordsEqual(_ lhs: ComboChord, _ rhs: ComboChord) -> Bool {
        normalizedModifiers(lhs.modifiers) == normalizedModifiers(rhs.modifiers)
            && Set(lhs.keys) == Set(rhs.keys)
    }

    static func tokenIsDown(_ token: String, modifiers: NSEvent.ModifierFlags, keys: Set<String>) -> Bool {
        switch token {
        case "⌘", "Command", "Cmd": return modifiers.contains(.command)
        case "⇧", "Shift": return modifiers.contains(.shift)
        case "⌥", "Option", "Alt": return modifiers.contains(.option)
        case "⌃", "Control", "Ctrl": return modifiers.contains(.control)
        case "Fn": return modifiers.contains(.function)
        default: return keys.contains(normalizeKeyToken(token))
        }
    }

    static func parseSequence(combo: String, id: String) -> ParsedComboSequence {
        let tokens = combo.split(separator: " ").map(String.init)
        var parts: [[String]] = []
        var separator: String?
        var current: [String] = []

        for token in tokens {
            let lower = token.lowercased()
            if lower == "then" || lower == "after" {
                if !current.isEmpty {
                    parts.append(current)
                    current = []
                }
                separator = lower
            } else {
                current.append(token)
            }
        }
        if !current.isEmpty { parts.append(current) }

        if parts.count <= 1 {
            let part = parts.first ?? []
            return ParsedComboSequence(
                shortcutID: id,
                single: parseChord(part),
                primary: nil,
                secondary: nil,
                primaryTokens: part,
                secondaryTokens: []
            )
        }

        let primaryTokens: [String]
        let secondaryTokens: [String]
        if separator == "after" {
            primaryTokens = parts[1]
            secondaryTokens = parts[0]
        } else {
            primaryTokens = parts[0]
            secondaryTokens = parts[1]
        }

        return ParsedComboSequence(
            shortcutID: id,
            single: nil,
            primary: parseChord(primaryTokens),
            secondary: parseChord(secondaryTokens),
            primaryTokens: primaryTokens,
            secondaryTokens: secondaryTokens
        )
    }

    static func parseChord(_ tokens: [String]) -> ComboChord {
        var modifiers: NSEvent.ModifierFlags = []
        var keys: [String] = []

        for token in tokens {
            switch token {
            case "⌘", "Command", "Cmd": modifiers.insert(.command)
            case "⇧", "Shift": modifiers.insert(.shift)
            case "⌥", "Option", "Alt": modifiers.insert(.option)
            case "⌃", "Control", "Ctrl": modifiers.insert(.control)
            case "Fn": modifiers.insert(.function)
            default: keys.append(normalizeKeyToken(token))
            }
        }

        return ComboChord(modifiers: modifiers, keys: keys)
    }

    static func keyToken(from event: NSEvent) -> String? {
        switch event.keyCode {
        case 49: return "space"
        case 48: return "tab"
        case 53: return "esc"
        case 51: return "delete"
        case 117: return "delete"
        case 123: return "←"
        case 124: return "→"
        case 125: return "↓"
        case 126: return "↑"
        case 18: return "1"
        case 19: return "2"
        case 20: return "3"
        case 21: return "4"
        case 23: return "5"
        case 22: return "6"
        case 26: return "7"
        case 28: return "8"
        case 25: return "9"
        case 29: return "0"
        default:
            if let chars = event.charactersIgnoringModifiers, !chars.isEmpty {
                if chars.count == 1, let scalar = chars.unicodeScalars.first, scalar.properties.isEmoji {
                    return nil
                }
                return chars.lowercased()
            }
            if let chars = event.characters, !chars.isEmpty {
                return chars.lowercased()
            }
            return nil
        }
    }

    static func normalizeKeyToken(_ token: String) -> String {
        switch token {
        case "Space": "space"
        case "Tab": "tab"
        case "Esc", "Escape": "esc"
        case "Delete", "Del", "⌫": "delete"
        case "Backspace": "delete"
        case "Record": "record"
        case "Page": "page"
        case "Down": "down"
        case "Up": "up"
        case "←": "←"
        case "→": "→"
        case "↑": "↑"
        case "↓": "↓"
        default: token.lowercased()
        }
    }
}
