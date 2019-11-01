import UIKit

/**
 * A standard button.
 */
class PrimaryButton: UIButton {
    init(title: String) {
        super.init(frame: .zero)

        clipsToBounds = true
        setBackgroundImage(imageWithColor(Theme.Color.primary.uiColor), for: .normal)
        setBackgroundImage(imageWithColor(Theme.Color.primary.uiColor, alpha: 0.2), for: .disabled)

        layer.cornerRadius = Theme.Metric.borderRadius.pointValue
        textStyle = .body2Reversed
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 44.0)
        ])

        setTitle(title, for: .normal)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 44.0)
    }

    private func imageWithColor(_ color: UIColor, alpha: CGFloat = 1.0) -> UIImage? {
        let baseColor = color.withAlphaComponent(alpha).cgColor

        let pixelRect = CGRect(origin: .zero, size: CGSize(width: 1.0, height: 1.0))
        UIGraphicsBeginImageContext(pixelRect.size)
        let cgContext = UIGraphicsGetCurrentContext()
        cgContext?.setFillColor(baseColor)
        cgContext?.fill(pixelRect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
