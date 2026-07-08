import AppKit
import SwiftUI

final class AboutWindowController: NSWindowController {
    static let shared = AboutWindowController()

    private init() {
        let hosting = NSHostingController(rootView: AboutView())
        hosting.safeAreaRegions = []

        let contentSize = AboutView.preferredContentSize
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: contentSize.width, height: contentSize.height),
            styleMask: [.titled, .closable],
            backing: .buffered,
            defer: false
        )
        window.title = "About Mac Hotkeys"
        window.isReleasedWhenClosed = false
        window.contentViewController = hosting

        super.init(window: window)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func show() {
        guard let window,
              let hosting = window.contentViewController as? NSHostingController<AboutView> else { return }

        let contentSize = AboutView.preferredContentSize
        window.setContentSize(contentSize)
        hosting.view.frame = NSRect(origin: .zero, size: contentSize)
        window.center()
        NSApp.activate(ignoringOtherApps: true)
        window.makeKeyAndOrderFront(nil)
    }
}
