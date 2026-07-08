import SwiftUI
import AppKit

struct AssetIconView: View {
    let name: String
    let color: Color
    var glyphSize: CGFloat = 20

    init(_ name: String, color: Color, glyphSize: CGFloat = 20) {
        self.name = name
        self.color = color
        self.glyphSize = glyphSize
    }

    var body: some View {
        Group {
            if let image = loadImage() {
                color.mask {
                    Image(nsImage: image)
                        .resizable()
                        .interpolation(.high)
                        .antialiased(true)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: glyphSize, height: glyphSize)
                }
                .frame(width: glyphSize, height: glyphSize)
            }
        }
    }

    private func loadImage() -> NSImage? {
        let subdirs = ["assets/icons", "Resources/assets/icons"]
        for subdir in subdirs {
            guard let url = Bundle.main.url(forResource: name, withExtension: "svg", subdirectory: subdir),
                  let image = NSImage(contentsOf: url) else { continue }
            image.isTemplate = false
            return image
        }
        return nil
    }
}

enum IconMetrics {
    static func glyphSize(forIcon icon: String, base: CGFloat) -> CGFloat {
        switch icon {
        case "basic": base * 1.35
        case "systems": base * 1.32
        default: base
        }
    }
}

enum UIIcons {
    static func search(color: Color, size: CGFloat = 21) -> some View {
        SearchIcon().stroke(color, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .frame(width: size, height: size)
    }

    static func moon(color: Color, size: CGFloat = 21) -> some View {
        MoonIcon().stroke(color, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .frame(width: size, height: size)
    }

    static func sun(color: Color, size: CGFloat = 21) -> some View {
        SunIcon().stroke(color, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .frame(width: size, height: size)
    }
}

private struct SearchIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let s = min(rect.width, rect.height) / 24
        p.addEllipse(in: CGRect(x: 4 * s, y: 4 * s, width: 14 * s, height: 14 * s))
        p.move(to: CGPoint(x: 16.5 * s, y: 16.5 * s))
        p.addLine(to: CGPoint(x: 20 * s, y: 20 * s))
        return p
    }
}

private struct MoonIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let s = min(rect.width, rect.height) / 24
        p.addArc(center: CGPoint(x: 12 * s, y: 12 * s), radius: 8.5 * s,
                 startAngle: .degrees(-60), endAngle: .degrees(240), clockwise: false)
        return p
    }
}

private struct SunIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let s = min(rect.width, rect.height) / 24
        p.addEllipse(in: CGRect(x: 8 * s, y: 8 * s, width: 8 * s, height: 8 * s))
        let rays: [(CGFloat, CGFloat, CGFloat, CGFloat)] = [
            (12, 2, 12, 4), (12, 20, 12, 22), (2, 12, 4, 12), (20, 12, 22, 12),
            (4.93, 4.93, 6.34, 6.34), (17.66, 17.66, 19.07, 19.07),
            (4.93, 19.07, 6.34, 17.66), (17.66, 6.34, 19.07, 4.93)
        ]
        for ray in rays {
            p.move(to: CGPoint(x: ray.0 * s, y: ray.1 * s))
            p.addLine(to: CGPoint(x: ray.2 * s, y: ray.3 * s))
        }
        return p
    }
}
