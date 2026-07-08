import AppKit
import SwiftUI

struct AboutView: View {
    private static let contentWidth: CGFloat = 570

    private let imageURL: URL? = {
        let bundle = Bundle.main
        let candidates = [
            bundle.url(forResource: "image", withExtension: "png", subdirectory: "assets"),
            bundle.url(forResource: "image", withExtension: "png", subdirectory: "Resources/assets"),
            bundle.url(forResource: "image", withExtension: "png")
        ]
        return candidates.compactMap { $0 }.first
    }()

    var body: some View {
        VStack(spacing: 14) {
            Group {
                if let imageURL, let nsImage = NSImage(contentsOf: imageURL) {
                    Image(nsImage: nsImage)
                        .resizable()
                        .interpolation(.high)
                        .scaledToFill()
                        .scaleEffect(1.22)
                        .frame(width: 140, height: 140)
                        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                } else {
                    Text("⌘")
                        .font(.system(size: 60, weight: .semibold))
                        .frame(width: 140, height: 140)
                }
            }

            Text("Mac Hotkeys")
                .font(.system(size: 24, weight: .bold))
                .fixedSize(horizontal: false, vertical: true)

            Text("Alexander Lim")
                .font(.system(size: 14))
                .fixedSize(horizontal: false, vertical: true)

            Text("Version 1.0")
                .font(.system(size: 13))
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)

            Text("Free License")
                .font(.system(size: 13))
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)

            Text("Keyboard shortcuts reference for macOS.")
                .font(.system(size: 13))
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)

            Text("Created with SwiftUI.")
                .font(.system(size: 13))
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)

            Text("Copyright © 2026 Alexander Lim.")
                .font(.system(size: 12))
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(width: Self.contentWidth - 68)
        .padding(.horizontal, 34)
        .padding(.vertical, 30)
        .fixedSize(horizontal: false, vertical: true)
    }

    static var preferredContentSize: NSSize {
        let hosting = NSHostingController(rootView: AboutView())
        hosting.view.layoutSubtreeIfNeeded()
        let fit = hosting.sizeThatFits(in: NSSize(width: contentWidth, height: CGFloat.greatestFiniteMagnitude))
        return NSSize(width: contentWidth, height: ceil(fit.height))
    }
}
