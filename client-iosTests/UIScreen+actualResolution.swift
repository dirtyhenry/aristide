import UIKit

extension UIScreen {
    static let actualResolution: String = {
        "\(UIScreen.main.nativeBounds.size)"
    }()
}

extension CGSize: CustomStringConvertible {
    public var description: String {
        return "\(Int(width))x\(Int(height))"
    }
}
