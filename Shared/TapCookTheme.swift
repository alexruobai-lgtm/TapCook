import SwiftUI

enum TapCookTheme {
    static let orange = Color(red: 0.96, green: 0.35, blue: 0.10)
    static let orangeLight = Color(red: 1.00, green: 0.73, blue: 0.48)
    static let cream = Color(red: 1.00, green: 0.97, blue: 0.92)
    static let ink = Color(red: 0.18, green: 0.11, blue: 0.08)
    static let green = Color(red: 0.20, green: 0.55, blue: 0.31)

    static func color(hex: String) -> Color {
        let clean = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        guard let value = UInt64(clean, radix: 16), clean.count == 6 else { return orange }
        return Color(
            red: Double((value >> 16) & 0xFF) / 255,
            green: Double((value >> 8) & 0xFF) / 255,
            blue: Double(value & 0xFF) / 255
        )
    }
}
