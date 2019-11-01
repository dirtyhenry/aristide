import UIKit

/**
 * A structure describing the theme of our application.
 */
struct Theme {
    struct Color {
        let hexString: String
        let alpha: CGFloat

        private init(_ hexString: String, alpha: CGFloat = 1.0) {
            self.hexString = hexString
            self.alpha = alpha
        }

        private func withAlphaComponent(_ alpha: CGFloat) -> Color {
            return Color(hexString, alpha: alpha)
        }

        // Gray shades
        private static let codGray = Color("#191919")
        private static let dustyGray = Color("#969696")
        private static let mercury = Color("#e1e1e1")
        static let white = Color("#ffffff")

        // Blue shades
        private static let governorBay = Color("#3a50c0")

        // States colors
        private static let monza = Color("#e60c0c")

        // Other colors
        private static let supernova = Color("#ffcc00")

        static let background = white
        static let overlayBackground = codGray.withAlphaComponent(0.4)

        static let primary = governorBay

        static let text = codGray
        static let textHighlighted = governorBay
        static let textReversed = white
        static let textSubdued = dustyGray

        static let inputBorder = mercury
        static let inputBorderActive = governorBay
        static let inputBorderErrored = monza
        static let inputBorderScanned = supernova
    }

    struct Metric {
        let rawValue: Int

        init(_ rawValue: Int) {
            self.rawValue = rawValue
        }

        static let borderRadius = Metric(3)
        static let maskBorderWidth = Metric(3)
    }

    struct Spacing {
        let rawValue: Float

        init(_ rawValue: Float) {
            self.rawValue = rawValue
        }

        // swiftlint:disable identifier_name
        static let s1 = Spacing(1)
        static let s2 = Spacing(2)
        static let s4 = Spacing(4)
        static let s6 = Spacing(6)
        static let s7 = Spacing(7)
        // swiftlint:enable identifier_name
    }

    struct TextStyle {
        let color: Theme.Color
        let size: CGFloat

        init(color: Theme.Color, size: CGFloat) {
            self.color = color
            self.size = size
        }

        static let headingInk = TextStyle(color: .text, size: 22.0)
        static let headingReversed = TextStyle(color: .textReversed, size: 22.0)
        static let subheading2Ink = TextStyle(color: .text, size: 16.0)
        static let subheading2Reversed = TextStyle(color: .textReversed, size: 16.0)
        static let subheading2Subdued = TextStyle(color: .textSubdued, size: 16.0)
        static let body2Ink = TextStyle(color: .text, size: 14.0)
        static let body2Reversed = TextStyle(color: .textReversed, size: 14.0)
        static let body2Subdued = TextStyle(color: .textSubdued, size: 14.0)
        static let captionHighlighted = TextStyle(color: .textHighlighted, size: 11.0)
        static let captionSubdued = TextStyle(color: .textSubdued, size: 11.0)
    }
}

extension Theme.Color {
    var uiColor: UIColor {
        let red, green, blue: CGFloat

        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = String(hexString[start...])

            if hexColor.count == 6 {
                let scanner = Scanner(string: "\(hexColor)ff")
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    red = CGFloat((hexNumber & 0xFF00_0000) >> 24) / 255
                    green = CGFloat((hexNumber & 0x00FF_0000) >> 16) / 255
                    blue = CGFloat((hexNumber & 0x0000_FF00) >> 8) / 255

                    return UIColor(red: red, green: green, blue: blue, alpha: alpha)
                }
            }
        }

        fatalError("Couldn't transform \(hexString) into UIColor")
    }
}

extension Theme.Color: CustomStringConvertible {
    var description: String {
        return "\(hexString) (alpha: \(alpha))"
    }
}

extension Theme.Metric {
    var pointValue: CGFloat {
        return CGFloat(rawValue)
    }
}

extension Theme.Spacing {
    var pointValue: CGFloat {
        return CGFloat(8.0 * rawValue)
    }
}

extension Theme.TextStyle {
    var font: UIFont {
        return UIFont.systemFont(ofSize: size)
    }
}
