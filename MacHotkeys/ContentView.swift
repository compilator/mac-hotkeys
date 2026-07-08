import SwiftUI

private enum Layout {
    static let windowWidth: CGFloat = 1180
    static let windowHeight: CGFloat = 780
    static let sidebarWidth: CGFloat = 270
    static let sidebarPadding: CGFloat = 20
    static let mainPadding: CGFloat = 28
    static let mainTopInset: CGFloat = 20
    static let cardSpacing: CGFloat = 18
    static let cardMinWidth: CGFloat = 380
    static let keycapAreaWidth: CGFloat = 120
    static let keycapAreaWidthExpanded: CGFloat = 130
    static let rowSpacing: CGFloat = 12
    static let sidebarItemHeight: CGFloat = 50
}

struct ContentView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @ObservedObject private var keyMonitor = ShortcutKeyMonitor.shared
    @FocusState private var isSearchFocused: Bool

    @State private var data = ShortcutsStore.load()
    @State private var activeCategory = "all"
    @State private var searchQuery = ""

    private var theme: AppTheme { isDarkMode ? .dark : .light }

    private var filtered: [Shortcut] {
        ShortcutsStore.filtered(shortcuts: data.shortcuts, categories: data.categories, activeCategory: activeCategory, query: searchQuery)
    }

    private var groups: [(category: Category, items: [Shortcut])] {
        ShortcutsStore.grouped(shortcuts: filtered, categories: data.categories)
    }

    private var isSingleCategory: Bool {
        activeCategory != "all" && groups.count == 1
    }

    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            SidebarView(
                theme: theme,
                categories: data.categories,
                shortcuts: data.shortcuts,
                totalCount: data.shortcuts.count,
                activeCategory: $activeCategory
            )
            .frame(width: Layout.sidebarWidth)

            MainPanelView(
                theme: theme,
                isDarkMode: $isDarkMode,
                searchQuery: $searchQuery,
                isSearchFocused: $isSearchFocused,
                activeCategory: activeCategory,
                filtered: filtered,
                groups: groups,
                isSingleCategory: isSingleCategory
            )
        }
        .frame(width: Layout.windowWidth, height: Layout.windowHeight)
        .background {
            WallpaperBackground(theme: theme)
        }
        .frame(width: Layout.windowWidth, height: Layout.windowHeight)
        .clipped()
        .preferredColorScheme(isDarkMode ? .dark : .light)
        .animation(AppMotion.quick, value: isDarkMode)
        .animation(AppMotion.standard, value: activeCategory)
        .onAppear {
            keyMonitor.updateShortcuts(data.shortcuts)
        }
        .onChange(of: isSearchFocused) { _, focused in
            keyMonitor.isSearchFieldFocused = focused
        }
        .onReceive(NotificationCenter.default.publisher(for: .resignSearchFocus)) { _ in
            isSearchFocused = false
        }
    }
}

// MARK: - Icon chip

private struct IconChip: View {
    let theme: AppTheme
    let name: String
    let color: Color
    var size: CGFloat = 34
    var cornerRadius: CGFloat = 11
    var glyphSize: CGFloat = 20

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .fill(theme.chip)
                .overlay {
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .strokeBorder(theme.line, lineWidth: 1)
                }
            AssetIconView(name, color: color, glyphSize: glyphSize)
        }
        .frame(width: size, height: size)
    }
}

// MARK: - Sidebar

private struct SidebarView: View {
    let theme: AppTheme
    let categories: [Category]
    let shortcuts: [Shortcut]
    let totalCount: Int
    @Binding var activeCategory: String

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Mac Hotkeys")
                    .font(.sfPro(20.4, weight: .semibold))
                    .foregroundStyle(theme.text)
                Text("Keyboard Shortcuts")
                    .font(.sfPro(13))
                    .foregroundStyle(theme.muted)
            }
            .padding(.horizontal, 6)
            .padding(.vertical, 8)

            SidebarButton(
                theme: theme,
                icon: "all-shortcut",
                iconColor: theme.categoryColor("blue"),
                title: "All Shortcuts",
                count: totalCount,
                isActive: activeCategory == "all"
            ) {
                withAnimation(AppMotion.standard) { activeCategory = "all" }
            }

            VStack(spacing: 6) {
                ForEach(categories) { category in
                    SidebarButton(
                        theme: theme,
                        icon: category.icon,
                        iconColor: theme.categoryColor(category.color),
                        title: category.title,
                        count: ShortcutsStore.count(for: category.id, in: shortcuts),
                        isActive: activeCategory == category.id
                    ) {
                        withAnimation(AppMotion.standard) { activeCategory = category.id }
                    }
                }
            }

            Spacer(minLength: 0)
        }
        .padding(Layout.sidebarPadding)
        .padding(.top, 28)
        .frame(maxHeight: .infinity, alignment: .top)
        .background(theme.panel2)
        .overlay(alignment: .trailing) {
            Rectangle().fill(theme.line).frame(width: 1)
        }
    }
}

private struct SidebarButton: View {
    let theme: AppTheme
    let icon: String
    let iconColor: Color
    let title: String
    let count: Int
    let isActive: Bool
    let action: () -> Void

    @State private var isHovered = false

    var body: some View {
        Button(action: action) {
            HStack(alignment: .center, spacing: 10) {
                IconChip(
                    theme: theme,
                    name: icon,
                    color: iconColor,
                    size: 34,
                    cornerRadius: 11,
                    glyphSize: IconMetrics.glyphSize(forIcon: icon, base: 20)
                )

                Text(title)
                    .font(.sfPro(14, weight: isActive ? .semibold : .regular))
                    .foregroundStyle(theme.text)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text("\(count)")
                    .font(.sfPro(13))
                    .foregroundStyle(theme.muted)
            }
            .padding(.horizontal, 10)
            .frame(height: Layout.sidebarItemHeight)
            .background {
                if isActive || isHovered {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(theme.hover)
                        .overlay {
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .stroke(theme.innerLine, lineWidth: 1)
                                .padding(1)
                        }
                }
            }
        }
        .buttonStyle(.plain)
        .animation(AppMotion.standard, value: isActive)
        .animation(AppMotion.quick, value: isHovered)
        .onHover { isHovered = $0 }
    }
}

// MARK: - Main Panel

private struct MainPanelView: View {
    let theme: AppTheme
    @Binding var isDarkMode: Bool
    @Binding var searchQuery: String
    var isSearchFocused: FocusState<Bool>.Binding
    let activeCategory: String
    let filtered: [Shortcut]
    let groups: [(category: Category, items: [Shortcut])]
    let isSingleCategory: Bool

    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .leading, spacing: 0) {
                ToolbarView(
                    theme: theme,
                    isDarkMode: $isDarkMode,
                    searchQuery: $searchQuery,
                    isSearchFocused: isSearchFocused
                )
                    .padding(.bottom, 18)

                KeyLegendView(theme: theme)
                    .padding(.bottom, 18)

                if filtered.isEmpty {
                    EmptyStateView(theme: theme)
                        .transition(.opacity.combined(with: .offset(y: 6)))
                } else {
                    CardsGridView(
                        theme: theme,
                        groups: groups,
                        isSingleCategory: isSingleCategory
                    )
                    .transition(.opacity.combined(with: .offset(y: 6)))
                }
            }
            .padding(.horizontal, Layout.mainPadding)
            .padding(.top, Layout.mainTopInset)
            .padding(.bottom, Layout.mainPadding)
            .frame(maxWidth: .infinity, alignment: .leading)
            .animation(AppMotion.standard, value: filtered.count)
            .animation(AppMotion.standard, value: activeCategory)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .simultaneousGesture(TapGesture().onEnded {
            isSearchFocused.wrappedValue = false
        })
    }
}

private struct ToolbarView: View {
    let theme: AppTheme
    @Binding var isDarkMode: Bool
    @Binding var searchQuery: String
    var isSearchFocused: FocusState<Bool>.Binding

    @State private var themeHovered = false

    var body: some View {
        HStack(alignment: .top, spacing: 18) {
            VStack(alignment: .leading, spacing: 0) {
                Text("macOS 26 style reference")
                    .font(.sfPro(11, weight: .heavy))
                    .kerning(1.32)
                    .textCase(.uppercase)
                    .foregroundStyle(theme.muted)
                    .padding(.bottom, 6)

                Text("Keyboard Shortcuts")
                    .font(.sfPro(34, weight: .bold))
                    .tracking(-1.02)
                    .foregroundStyle(theme.text)
                    .lineLimit(1)
                    .minimumScaleFactor(0.85)

                Text("Полный справочник горячих клавиш macOS с поиском и категориями.")
                    .font(.sfPro(15))
                    .foregroundStyle(theme.muted)
                    .padding(.top, 7)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer(minLength: 12)

            HStack(spacing: 10) {
                HStack(spacing: 10) {
                    UIIcons.search(color: theme.searchPlaceholder)
                    TextField(
                        "",
                        text: $searchQuery,
                        prompt: Text("Поиск: screenshot, finder, ⌘ ⇧ 4…")
                            .font(.system(size: 16))
                            .foregroundStyle(theme.searchPlaceholder)
                    )
                    .textFieldStyle(.plain)
                    .font(.system(size: 16))
                    .foregroundStyle(theme.searchText)
                    .tint(theme.searchText)
                    .focused(isSearchFocused)
                    .onKeyPress(.escape) {
                        isSearchFocused.wrappedValue = false
                        return .handled
                    }
                }
                .padding(.horizontal, 13)
                .frame(width: 380, height: 44)
                .background(theme.searchField, in: RoundedRectangle(cornerRadius: 15, style: .continuous))
                .overlay {
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .strokeBorder(theme.line, lineWidth: 1)
                }

                Button {
                    isDarkMode.toggle()
                } label: {
                    Image(systemName: isDarkMode ? "sun.max.fill" : "moon.fill")
                        .font(.system(size: 19, weight: .medium))
                        .foregroundStyle(theme.text)
                        .frame(width: 44, height: 44)
                        .background(
                            themeHovered ? theme.hover : theme.chip,
                            in: RoundedRectangle(cornerRadius: 15, style: .continuous)
                        )
                        .overlay {
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .strokeBorder(theme.line, lineWidth: 1)
                        }
                }
                .buttonStyle(.plain)
                .animation(AppMotion.quick, value: themeHovered)
                .animation(AppMotion.quick, value: isDarkMode)
                .onHover { themeHovered = $0 }
            }
        }
    }
}

private struct KeyLegendView: View {
    let theme: AppTheme

    var body: some View {
        HStack(spacing: 10) {
            Text("Key legend")
                .font(.sfPro(13, weight: .bold))
                .foregroundStyle(theme.text)
                .padding(.trailing, 4)

            legendItem(key: "⌘", label: "Command")
            legendItem(key: "⇧", label: "Shift")
            legendItem(key: "⌥", label: "Option")
            legendItem(key: "⌃", label: "Control")
            legendItem(text: "Fn", label: "Function")

            Spacer(minLength: 0)
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 13)
        .modifier(PanelChip(theme: theme, radius: 17))
    }

    @ViewBuilder
    private func legendItem(key: String? = nil, text: String? = nil, label: String) -> some View {
        HStack(spacing: 9) {
            KeycapView(theme: theme, tokens: key.map { [$0] } ?? [], text: text)
            Text(label)
                .font(.sfPro(13))
                .foregroundStyle(theme.muted)
        }
    }
}

// MARK: - Cards

private struct CardsGridView: View {
    let theme: AppTheme
    let groups: [(category: Category, items: [Shortcut])]
    let isSingleCategory: Bool

    private var columns: [GridItem] {
        [
            GridItem(.flexible(minimum: Layout.cardMinWidth), spacing: Layout.cardSpacing, alignment: .top),
            GridItem(.flexible(minimum: Layout.cardMinWidth), spacing: Layout.cardSpacing, alignment: .top)
        ]
    }

    var body: some View {
        if isSingleCategory, let group = groups.first {
            CategoryCardView(theme: theme, group: group, expanded: true)
                .frame(maxWidth: .infinity, alignment: .leading)
                .transition(.opacity.combined(with: .offset(y: 6)))
        } else {
            LazyVGrid(columns: columns, alignment: .leading, spacing: Layout.cardSpacing) {
                ForEach(groups, id: \.category.id) { group in
                    CategoryCardView(theme: theme, group: group, expanded: false)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .transition(.opacity.combined(with: .offset(y: 6)))
                }
            }
        }
    }
}

private struct CategoryCardView: View {
    let theme: AppTheme
    let group: (category: Category, items: [Shortcut])
    let expanded: Bool

    @State private var isHovered = false

    private var catColor: Color { theme.categoryColor(group.category.color) }

    private var expandedColumns: [GridItem] {
        [
            GridItem(.flexible(minimum: 320), spacing: 18, alignment: .top),
            GridItem(.flexible(minimum: 320), spacing: 18, alignment: .top)
        ]
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            cardHead
                .padding(.bottom, expanded ? 18 : 12)

            if expanded {
                LazyVGrid(columns: expandedColumns, alignment: .leading, spacing: 4) {
                    ForEach(group.items) { shortcut in
                        ShortcutRowView(theme: theme, shortcut: shortcut, expanded: true)
                    }
                }
            } else {
                VStack(spacing: 0) {
                    ForEach(group.items) { shortcut in
                        ShortcutRowView(theme: theme, shortcut: shortcut, expanded: false)
                    }
                }
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .modifier(PanelCard(theme: theme, radius: 24))
        .animation(AppMotion.quick, value: isHovered)
        .onHover { isHovered = $0 }
    }

    @ViewBuilder
    private var cardHead: some View {
        if expanded {
            HStack(alignment: .center, spacing: 14) {
                IconChip(
                    theme: theme,
                    name: group.category.icon,
                    color: catColor,
                    size: 40,
                    cornerRadius: 15,
                    glyphSize: IconMetrics.glyphSize(forIcon: group.category.icon, base: 22)
                )

                VStack(alignment: .leading, spacing: 2) {
                    Text(group.category.title)
                        .font(.sfPro(16, weight: .heavy))
                        .foregroundStyle(catColor)
                    Text(group.category.description)
                        .font(.sfPro(12))
                        .foregroundStyle(theme.muted)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                }

                Spacer(minLength: 12)

                Text("\(group.items.count)")
                    .font(.sfPro(12, weight: .medium))
                    .foregroundStyle(theme.muted)
                    .padding(.horizontal, 12)
                    .frame(minWidth: 42, minHeight: 34)
                    .background(theme.chip, in: RoundedRectangle(cornerRadius: 17, style: .continuous))
                    .overlay {
                        RoundedRectangle(cornerRadius: 17, style: .continuous)
                            .strokeBorder(theme.line, lineWidth: 1)
                    }
            }
            .padding(16)
            .modifier(HeaderPlate(theme: theme, radius: 20))
        } else {
            HStack(alignment: .center, spacing: 11) {
                IconChip(
                    theme: theme,
                    name: group.category.icon,
                    color: catColor,
                    size: 36,
                    cornerRadius: 12,
                    glyphSize: IconMetrics.glyphSize(forIcon: group.category.icon, base: 20)
                )

                VStack(alignment: .leading, spacing: 2) {
                    Text(group.category.title)
                        .font(.sfPro(16, weight: .heavy))
                        .foregroundStyle(catColor)
                        .lineLimit(1)
                    Text(group.category.description)
                        .font(.sfPro(12))
                        .foregroundStyle(theme.muted)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                }

                Spacer(minLength: 4)

                Text("\(group.items.count)")
                    .font(.sfPro(12))
                    .foregroundStyle(theme.muted)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(theme.chip, in: Capsule())
                    .overlay(Capsule().strokeBorder(theme.line, lineWidth: 1))
            }
        }
    }
}

private struct ShortcutRowView: View {
    let theme: AppTheme
    let shortcut: Shortcut
    var expanded: Bool = false

    @ObservedObject private var keyMonitor = ShortcutKeyMonitor.shared
    @State private var isHovered = false

    private var isKeyboardMatched: Bool {
        keyMonitor.matchedShortcutID == shortcut.id
    }

    private var isPartialKeyboardMatched: Bool {
        keyMonitor.partialShortcutID == shortcut.id
    }

    private var showsRowHighlight: Bool {
        isKeyboardMatched || isPartialKeyboardMatched || isHovered
    }

    private var tokens: [String] {
        shortcut.combo.split(separator: " ").map(String.init)
    }

    private var keycapWidth: CGFloat {
        expanded ? Layout.keycapAreaWidthExpanded : Layout.keycapAreaWidth
    }

    var body: some View {
        HStack(alignment: .top, spacing: Layout.rowSpacing) {
            KeycapWrapView(
                theme: theme,
                keys: tokens,
                shortcutID: shortcut.id,
                rowHovered: isHovered,
                areaWidth: keycapWidth
            )
                .layoutPriority(0)

            VStack(alignment: .leading, spacing: 2) {
                Text(shortcut.title)
                    .font(.sfPro(14, weight: .semibold))
                    .foregroundStyle(theme.text)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                Text(shortcut.description)
                    .font(.sfPro(12))
                    .foregroundStyle(theme.muted)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .layoutPriority(1)
        }
        .padding(.horizontal, 6)
        .padding(.vertical, 8)
        .background {
            if showsRowHighlight {
                RoundedRectangle(cornerRadius: 13, style: .continuous)
                    .fill(
                        isPartialKeyboardMatched && !isKeyboardMatched
                            ? theme.hover.opacity(0.65)
                            : theme.hover
                    )
            }
        }
        .animation(AppMotion.quick, value: isHovered)
        .animation(AppMotion.matchFade, value: isKeyboardMatched)
        .animation(AppMotion.matchFade, value: isPartialKeyboardMatched)
        .onHover { isHovered = $0 }
    }
}

private struct KeycapWrapView: View {
    let theme: AppTheme
    let keys: [String]
    let shortcutID: String
    var rowHovered: Bool = false
    var areaWidth: CGFloat = Layout.keycapAreaWidth

    @ObservedObject private var keyMonitor = ShortcutKeyMonitor.shared

    private let maxPerRow = 3
    private let rowSpacing: CGFloat = 5

    private enum ComboPart: Identifiable {
        case keyRow([String])
        case separator(String)

        var id: String {
            switch self {
            case .keyRow(let keys): "keys-\(keys.joined(separator: "-"))"
            case .separator(let label): "sep-\(label)"
            }
        }
    }

    private var parts: [ComboPart] {
        Self.parseParts(from: keys)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: rowSpacing) {
            ForEach(Array(parts.enumerated()), id: \.offset) { _, part in
                switch part {
                case .keyRow(let rowKeys):
                    ForEach(Array(chunked(rowKeys).enumerated()), id: \.offset) { _, row in
                        keycapRow(row)
                    }
                case .separator(let label):
                    ComboSeparatorView(theme: theme, label: label)
                }
            }
        }
        .frame(width: areaWidth, alignment: .leading)
        .layoutPriority(0)
    }

    private func chunked(_ keys: [String]) -> [[String]] {
        var rows: [[String]] = []
        var current: [String] = []
        var currentWidth: CGFloat = 0

        for key in keys {
            let keyWidth = Self.estimatedKeycapWidth(for: key)
            let plusWidth: CGFloat = current.isEmpty ? 0 : 14

            if !current.isEmpty, current.count >= maxPerRow || currentWidth + plusWidth + keyWidth > areaWidth {
                rows.append(current)
                current = [key]
                currentWidth = keyWidth
            } else {
                currentWidth += plusWidth + keyWidth
                current.append(key)
            }
        }

        if !current.isEmpty {
            rows.append(current)
        }

        return rows
    }

    static func estimatedKeycapWidth(for token: String) -> CGFloat {
        let label = displayLabel(for: token)
        let isWide = label.count > 2 || wideLabels.contains(label)
        if isWide {
            return CGFloat(label.count) * 7.5 + KeycapMetrics.hPadding * 2
        }
        return KeycapMetrics.minWidth
    }

    private static let wideLabels: Set<String> = [
        "Space", "Tab", "Esc", "Delete", "Record", "Page", "Fn", "Menu", "Drag", "Click", "Power", "Down", "Up"
    ]

    private func keycapRow(_ row: [String]) -> some View {
        HStack(spacing: 0) {
            ForEach(Array(row.enumerated()), id: \.offset) { index, key in
                if index > 0 {
                    Text("+")
                        .font(.sfPro(10.5))
                        .foregroundStyle(theme.muted.opacity(0.35))
                        .padding(.horizontal, 2)
                        .fixedSize()
                }
                KeycapView(
                    theme: theme,
                    label: KeycapWrapView.displayLabel(for: key),
                    pressed: keyMonitor.isTokenPressed(token: key, shortcutID: shortcutID)
                        || (rowHovered && !keyMonitor.hasActiveKeyboardMatch(for: shortcutID))
                )
            }
        }
        .frame(minHeight: KeycapMetrics.height + 2, alignment: .top)
    }

    private static func parseParts(from keys: [String]) -> [ComboPart] {
        var parts: [ComboPart] = []
        var current: [String] = []

        for key in keys {
            let lower = key.lowercased()
            if lower == "then" || lower == "after" {
                if !current.isEmpty {
                    parts.append(.keyRow(current))
                    current = []
                }
                parts.append(.separator(lower))
            } else {
                current.append(key)
            }
        }

        if !current.isEmpty {
            parts.append(.keyRow(current))
        }

        return parts
    }

    static func displayLabel(for token: String) -> String {
        switch token {
        case "Shift": "⇧"
        case "Command", "Cmd": "⌘"
        case "Option", "Alt": "⌥"
        case "Control", "Ctrl": "⌃"
        case "Backspace": "⌫"
        case "Del": "Delete"
        default: token
        }
    }
}

private struct ComboSeparatorView: View {
    let theme: AppTheme
    let label: String

    var body: some View {
        Text(label)
            .font(.sfPro(10.5))
            .foregroundStyle(theme.muted.opacity(0.55))
            .padding(.vertical, 1)
    }
}

private struct KeycapView: View {
    let theme: AppTheme
    var tokens: [String] = []
    var text: String? = nil
    var label: String? = nil
    var pressed: Bool = false

    private static let wideLabels: Set<String> = [
        "Space", "Tab", "Esc", "Delete", "Record", "Page", "Fn", "Menu", "Drag", "Click", "Power"
    ]

    private var displayText: String {
        if let label { return label }
        if let text { return text }
        return tokens.joined()
    }

    private var isWideKey: Bool {
        displayText.count > 2 || Self.wideLabels.contains(displayText)
    }

    private var hPadding: CGFloat { KeycapMetrics.hPadding }
    private var glyphSize: CGFloat { KeycapMetrics.glyphSize }
    private var appliedMinWidth: CGFloat? { isWideKey ? nil : KeycapMetrics.minWidth }

    var body: some View {
        HStack(spacing: 0) {
            if let label {
                Text(label)
                    .font(.sfPro(glyphSize, weight: .bold))
                    .foregroundStyle(theme.text)
                    .fixedSize(horizontal: true, vertical: false)
            } else if let text {
                Text(text)
                    .font(.sfPro(glyphSize, weight: .bold))
                    .foregroundStyle(theme.text)
                    .fixedSize(horizontal: true, vertical: false)
            } else {
                ForEach(Array(tokens.enumerated()), id: \.offset) { _, token in
                    Text(token)
                        .font(.sfPro(glyphSize, weight: .bold))
                        .foregroundStyle(theme.text)
                        .fixedSize(horizontal: true, vertical: false)
                }
            }
        }
        .padding(.horizontal, hPadding)
        .frame(minWidth: appliedMinWidth)
        .frame(height: KeycapMetrics.height)
        .background {
            if pressed {
                LinearGradient(
                    colors: [Color.white.opacity(0.22), Color.black.opacity(0.06)],
                    startPoint: .top, endPoint: .bottom
                )
            } else {
                LinearGradient(
                    colors: [Color.white.opacity(0.36), Color.white.opacity(0.06)],
                    startPoint: .top, endPoint: .bottom
                )
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: KeycapMetrics.radius, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: KeycapMetrics.radius, style: .continuous)
                .strokeBorder(
                    pressed ? Color(hex: 0x007AFF).opacity(0.58) : theme.line.opacity(0.75),
                    lineWidth: pressed ? 0.85 : 0.75
                )
        }
        .shadow(color: .black.opacity(pressed ? 0.01 : 0.03), radius: pressed ? 0 : 0.25, y: pressed ? 0 : 0.5)
        .scaleEffect(pressed ? 0.97 : 1.0, anchor: .center)
        .frame(height: KeycapMetrics.height)
        .animation(AppMotion.keycapPress, value: pressed)
    }
}

private struct EmptyStateView: View {
    let theme: AppTheme

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(theme.chip)
                UIIcons.search(color: theme.muted, size: 28)
            }
            .frame(width: 54, height: 54)

            Text("Ничего не найдено")
                .font(.sfPro(20, weight: .bold))
                .foregroundStyle(theme.text)
                .padding(.top, 12)
                .padding(.bottom, 6)

            Text("Попробуй другой запрос или категорию.")
                .font(.sfPro(15))
                .foregroundStyle(theme.muted)
        }
        .frame(maxWidth: .infinity, minHeight: 280)
        .modifier(PanelCard(theme: theme, radius: 24))
    }
}

#Preview {
    ContentView()
}
