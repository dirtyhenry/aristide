@testable import client_ios
import SnapshotTesting
import UIKit

extension UIView {
    func wrapInView(
        size: CGSize,
        padding: Padding
    ) -> UIView {
        let parentView = UIView(frame: CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: size))
        parentView.backgroundColor = .white
        parentView.addSubview(self)

        var layoutConstraints: [NSLayoutConstraint] = []

        if let top = padding.top {
            layoutConstraints.append(topAnchor.constraint(equalTo: parentView.topAnchor, constant: top))
        }

        if let bottom = padding.bottom {
            layoutConstraints.append(bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -bottom))
        }

        if let leading = padding.leading {
            layoutConstraints.append(leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: leading))
        }

        if let trailing = padding.trailing {
            layoutConstraints.append(trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -trailing))
        }

        NSLayoutConstraint.activate(layoutConstraints)
        return parentView
    }
}

public func assertLocalizedSnapshot(
    matching sut: UIViewController,
    file: StaticString = #file,
    testName: String = #function,
    line: UInt = #line
) {
    let locale = NSLocale.preferredLanguages.first!
    UIApplication.shared.keyWindow?.rootViewController = sut
    assertSnapshot(
        matching: sut,
        as: .image(on: .iPhoneXr),
        named: "snap-\(locale)-\(UIScreen.actualResolution)",
        file: file,
        testName: testName,
        line: line
    )
}
