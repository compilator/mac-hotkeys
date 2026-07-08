import AppKit
import SwiftUI

extension Notification.Name {
    static let resignSearchFocus = Notification.Name("MacHotkeys.resignSearchFocus")
}

final class MenuBarController: NSObject {
    static let shared = MenuBarController()

    private static let statusItemLength: CGFloat = 28

    private var statusItem: NSStatusItem?
    private var statusMenu: NSMenu?
    private var window: NSWindow?
    private var hostingController: NSHostingController<ContentView>?
    private var didSetupStatusItem = false

    private var maximizeMenuItem: NSMenuItem?
    private var minimizeMenuItem: NSMenuItem?

    var isKeyWindow: Bool {
        window?.isKeyWindow == true
    }

    private var isWindowVisible: Bool {
        window?.isVisible == true
    }

    func start() {
        guard !didSetupStatusItem else { return }
        NSApp.setActivationPolicy(.accessory)
        setupStatusItem()
        didSetupStatusItem = true
    }

    private func setupStatusItem() {
        let item = NSStatusBar.system.statusItem(withLength: Self.statusItemLength)
        guard let button = item.button else { return }

        button.image = nil
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center

        let fontSize = 16.0 * 1.05
        let attributes: [NSAttributedString.Key: Any] = [
            .font: NSFont.systemFont(ofSize: fontSize, weight: .semibold),
            .foregroundColor: NSColor.secondaryLabelColor,
            .paragraphStyle: paragraph,
            .baselineOffset: 3
        ]
        button.attributedTitle = NSAttributedString(string: "⌘", attributes: attributes)
        button.imagePosition = .noImage
        button.toolTip = "Mac Hotkeys"
        button.isBordered = false
        button.focusRingType = .none
        button.setButtonType(.momentaryChange)

        let menu = NSMenu()
        menu.delegate = self

        let maximize = NSMenuItem(title: "Maximize", action: #selector(maximizeWindow), keyEquivalent: "")
        maximize.target = self
        menu.addItem(maximize)
        maximizeMenuItem = maximize

        let minimize = NSMenuItem(title: "Minimize", action: #selector(minimizeWindow), keyEquivalent: "")
        minimize.target = self
        minimize.isHidden = true
        menu.addItem(minimize)
        minimizeMenuItem = minimize

        let about = NSMenuItem(title: "About", action: #selector(showAbout), keyEquivalent: "")
        about.target = self
        menu.addItem(about)

        menu.addItem(.separator())

        let quit = NSMenuItem(title: "Quit", action: #selector(quitApp), keyEquivalent: "q")
        quit.target = self
        menu.addItem(quit)

        item.menu = menu
        statusMenu = menu
        statusItem = item
    }

    private func updateWindowMenuItems() {
        maximizeMenuItem?.isHidden = isWindowVisible
        minimizeMenuItem?.isHidden = !isWindowVisible
    }

    private func setupWindow() {
        let hosting = NSHostingController(rootView: ContentView())
        hosting.safeAreaRegions = []
        hostingController = hosting

        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 1180, height: 780),
            styleMask: [.titled, .closable, .miniaturizable, .fullSizeContentView],
            backing: .buffered,
            defer: false
        )
        window.title = "Mac Hotkeys"
        window.titlebarAppearsTransparent = true
        window.titleVisibility = .hidden
        window.isMovableByWindowBackground = true
        window.isOpaque = true
        window.backgroundColor = .clear
        window.hasShadow = true
        window.hidesOnDeactivate = false
        window.isReleasedWhenClosed = false
        window.collectionBehavior = [.moveToActiveSpace, .fullScreenAuxiliary]
        window.contentViewController = hosting
        window.delegate = self
        window.contentView?.wantsLayer = true
        window.contentView?.layer?.masksToBounds = true
        window.setContentSize(NSSize(width: 1180, height: 780))

        self.window = window
        ShortcutKeyMonitor.shared.setObservedWindow(window)
    }

    @objc private func maximizeWindow() {
        if window == nil {
            setupWindow()
        }
        guard let window, let hostingController else { return }

        window.setContentSize(NSSize(width: 1180, height: 780))
        window.center()
        constrainWindowToVisibleScreen(window)

        NSApp.setActivationPolicy(.regular)
        window.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
        window.makeFirstResponder(hostingController.view)
        NotificationCenter.default.post(name: .resignSearchFocus, object: nil)
        ShortcutKeyMonitor.shared.start()
    }

    @objc private func minimizeWindow() {
        guard let window else { return }
        window.orderOut(nil)
        NSApp.setActivationPolicy(.accessory)
        ShortcutKeyMonitor.shared.stop()
    }

    private func constrainWindowToVisibleScreen(_ window: NSWindow) {
        guard let screen = window.screen ?? NSScreen.main else { return }
        var frame = window.frame
        let visible = screen.visibleFrame

        if frame.width > visible.width {
            frame.size.width = visible.width
        }
        if frame.height > visible.height {
            frame.size.height = visible.height
        }
        if frame.maxX > visible.maxX {
            frame.origin.x = visible.maxX - frame.width
        }
        if frame.minX < visible.minX {
            frame.origin.x = visible.minX
        }
        if frame.maxY > visible.maxY {
            frame.origin.y = visible.maxY - frame.height
        }
        if frame.minY < visible.minY {
            frame.origin.y = visible.minY
        }

        window.setFrame(frame, display: false)
    }

    @objc private func showAbout() {
        AboutWindowController.shared.show()
    }

    @objc private func quitApp() {
        NSApplication.shared.terminate(nil)
    }
}

extension MenuBarController: NSMenuDelegate {
    func menuNeedsUpdate(_ menu: NSMenu) {
        updateWindowMenuItems()
    }
}

extension MenuBarController: NSWindowDelegate {
    func windowShouldClose(_ sender: NSWindow) -> Bool {
        sender.orderOut(nil)
        NSApp.setActivationPolicy(.accessory)
        ShortcutKeyMonitor.shared.stop()
        return false
    }

    func windowDidBecomeKey(_ notification: Notification) {
        ShortcutKeyMonitor.shared.start()
    }

    func windowDidResignKey(_ notification: Notification) {
        ShortcutKeyMonitor.shared.clearPressedInput()
    }
}

final class AppDelegate: NSObject, NSApplicationDelegate {
    private var menuBarStatusItem: NSStatusItem?

    func applicationWillFinishLaunching(_ notification: Notification) {
        MenuBarController.shared.start()
        menuBarStatusItem = MenuBarController.shared.retainStatusItem()
        ShortcutKeyMonitor.shared.start()
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        false
    }
}

extension MenuBarController {
    func retainStatusItem() -> NSStatusItem? {
        statusItem
    }
}
