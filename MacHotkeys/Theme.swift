import SwiftUI

enum AppTheme {
    case light, dark

    var bg1: Color { Color(hex: isDark ? 0x061124 : 0x86D7FF) }
    var bg2: Color { Color(hex: isDark ? 0x17246F : 0x1455FF) }
    var bg3: Color { Color(hex: isDark ? 0x6C2CA2 : 0xDD77FF) }
    var window: Color { isDark ? Color(red: 0.075, green: 0.09, blue: 0.133, opacity: 1.0) : Color(red: 0.97, green: 0.98, blue: 1.0, opacity: 1.0) }
    var panel2: Color { isDark ? Color(red: 0.055, green: 0.07, blue: 0.11, opacity: 0.58) : Color(red: 0.965, green: 0.973, blue: 1.0, opacity: 0.60) }
    var card: Color { isDark ? Color(red: 0.122, green: 0.145, blue: 0.204, opacity: 0.68) : Color.white.opacity(0.62) }
    var text: Color { Color(hex: isDark ? 0xF8FAFC : 0x0B1220).opacity(isDark ? 1.0 : 0.92) }
    var muted: Color { Color(hex: isDark ? 0xA1A9B7 : 0x2F3847).opacity(isDark ? 1.0 : 0.94) }
    var line: Color { isDark ? Color.white.opacity(0.12) : Color(red: 0.071, green: 0.094, blue: 0.149, opacity: 0.12) }
    var chip: Color { isDark ? Color.white.opacity(0.10) : Color.white.opacity(0.58) }
    var searchField: Color { isDark ? Color.white.opacity(0.12) : Color.white.opacity(0.86) }
    var searchText: Color { Color(hex: isDark ? 0xF8FAFC : 0x0B1220).opacity(0.92) }
    var searchPlaceholder: Color { Color(hex: isDark ? 0xA1A9B7 : 0x364152).opacity(0.90) }
    var hover: Color { isDark ? Color(red: 0.039, green: 0.518, blue: 1.0, opacity: 0.18) : Color(red: 0, green: 0.478, blue: 1.0, opacity: 0.13) }
    var innerLine: Color { isDark ? Color.white.opacity(0.11) : Color.white.opacity(0.55) }
    var headerPlate: Color { isDark ? Color(red: 0.145, green: 0.169, blue: 0.227, opacity: 0.88) : Color.white.opacity(0.84) }
    var mainGradientTop: Color { isDark ? Color.white.opacity(0.04) : Color.white.opacity(0.12) }

    private var isDark: Bool { self == .dark }

    func categoryColor(_ name: String) -> Color {
        switch name {
        case "blue": Color(hex: 0x007AFF)
        case "purple": Color(hex: 0x8B5CF6)
        case "green": Color(hex: 0x22A447)
        case "orange": Color(hex: 0xFF8A00)
        case "pink": Color(hex: 0xFF2D7A)
        case "indigo": Color(hex: 0x5856D6)
        case "teal": Color(hex: 0x00A7B7)
        case "brown": Color(hex: 0xA56B3F)
        case "red": Color(hex: 0xFF453A)
        default: Color(hex: 0x007AFF)
        }
    }
}

enum AppMotion {
    static let standard = Animation.easeInOut(duration: 0.22)
    static let quick = Animation.easeInOut(duration: 0.18)
    static let keycapPress = Animation.easeInOut(duration: 0.16)
    static let matchFade = Animation.easeInOut(duration: 0.26)
}

enum KeycapMetrics {
    static let height: CGFloat = 24
    static let minWidth: CGFloat = 24
    static let hPadding: CGFloat = 7
    static let radius: CGFloat = 5
    static let glyphSize: CGFloat = 13
}

extension Font {
    static func sfPro(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
}

extension Color {
    init(hex: UInt32) {
        let r = Double((hex >> 16) & 0xFF) / 255
        let g = Double((hex >> 8) & 0xFF) / 255
        let b = Double(hex & 0xFF) / 255
        self.init(red: r, green: g, blue: b)
    }
}

struct WallpaperBackground: View {
    let theme: AppTheme

    var body: some View {
        ZStack {
            theme.window
            LinearGradient(
                colors: [theme.bg2, Color(hex: 0x00183D)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            RadialGradient(colors: [theme.bg1, .clear], center: UnitPoint(x: 0.07, y: 0.12), startRadius: 0, endRadius: 400)
            RadialGradient(colors: [theme.bg3, .clear], center: UnitPoint(x: 0.84, y: 0.26), startRadius: 0, endRadius: 380)
            RadialGradient(colors: [Color(hex: 0x35FFC9), .clear], center: UnitPoint(x: 0.45, y: 1.0), startRadius: 0, endRadius: 320)
            LinearGradient(
                colors: [Color.white.opacity(0.24), .clear, Color.white.opacity(0.10)],
                startPoint: UnitPoint(x: 0, y: 0),
                endPoint: UnitPoint(x: 1, y: 0.6)
            )
            .blendMode(.overlay)
        }
        .saturation(1.18)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct AppShell: ViewModifier {
    let theme: AppTheme
    let isDark: Bool
    let radius: CGFloat

    func body(content: Content) -> some View {
        content
            .clipShape(RoundedRectangle(cornerRadius: radius, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: radius, style: .continuous)
                    .strokeBorder(theme.line, lineWidth: 1)
            }
    }
}

struct PanelCard: ViewModifier {
    let theme: AppTheme
    let radius: CGFloat

    func body(content: Content) -> some View {
        content
            .background(theme.card, in: RoundedRectangle(cornerRadius: radius, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: radius, style: .continuous)
                    .strokeBorder(theme.line, lineWidth: 1)
            }
            .overlay(alignment: .top) {
                RoundedRectangle(cornerRadius: radius, style: .continuous)
                    .stroke(theme.innerLine, lineWidth: 1)
                    .padding(1)
                    .allowsHitTesting(false)
            }
    }
}

struct PanelChip: ViewModifier {
    let theme: AppTheme
    let radius: CGFloat

    func body(content: Content) -> some View {
        content
            .background(theme.chip, in: RoundedRectangle(cornerRadius: radius, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: radius, style: .continuous)
                    .strokeBorder(theme.line, lineWidth: 1)
            }
    }
}

struct HeaderPlate: ViewModifier {
    let theme: AppTheme
    let radius: CGFloat

    func body(content: Content) -> some View {
        content
            .background(theme.headerPlate, in: RoundedRectangle(cornerRadius: radius, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: radius, style: .continuous)
                    .strokeBorder(theme.line, lineWidth: 1)
            }
            .overlay(alignment: .top) {
                RoundedRectangle(cornerRadius: radius, style: .continuous)
                    .stroke(theme.innerLine, lineWidth: 1)
                    .padding(1)
                    .allowsHitTesting(false)
            }
    }
}
