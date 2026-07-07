import SwiftUI

/// Bespoke palette for Scholarwatch: Track scholarship and grant applications with deadlines and status.
enum Theme {
    static let accent = Color(red: 0.831, green: 0.647, blue: 0.216)
    static let background = Color(red: 0.078, green: 0.063, blue: 0.039)
    static let card = Color(red: 0.141, green: 0.106, blue: 0.055)
    static let ink = Color(white: 0.95)
    static let mutedInk = Color(white: 0.65)

    static func titleFont(_ size: CGFloat = 28) -> Font {
        .system(size: size, weight: .bold, design: .serif)
    }
    static func bodyFont(_ size: CGFloat = 16) -> Font {
        .system(size: size, weight: .regular, design: .serif)
    }
    static func labelFont(_ size: CGFloat = 13) -> Font {
        .system(size: size, weight: .semibold, design: .serif)
    }

    static let cornerRadius: CGFloat = 18
}
