import AppKit

@main
enum MacHotkeysLauncher {
    private static let appDelegate = AppDelegate()

    static func main() {
        NSApplication.shared.delegate = appDelegate
        NSApplication.shared.run()
    }
}
