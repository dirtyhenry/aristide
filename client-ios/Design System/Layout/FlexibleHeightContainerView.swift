import UIKit

/**
 * An object that wraps a given view for a column arrangement with flexible spaces on top & bottom.
 *
 * These top & bottom spaces have an height related by a ratio, and a minimum height.
 */
class FlexibleHeightContainerView: UIView {
    private let topView = UIView()
    private let bottomView = UIView()

    init(containedView: UIView, minimumTopHeight: CGFloat, bottomHeightRatio: CGFloat) {
        super.init(frame: .zero)

        translatesAutoresizingMaskIntoConstraints = false
        topView.translatesAutoresizingMaskIntoConstraints = false
        containedView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(topView)
        addSubview(containedView)
        addSubview(bottomView)

        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: topAnchor),
            topView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topView.heightAnchor.constraint(greaterThanOrEqualToConstant: minimumTopHeight),

            containedView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            containedView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containedView.bottomAnchor.constraint(equalTo: bottomView.topAnchor),

            bottomView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomView.heightAnchor.constraint(equalTo: topView.heightAnchor, multiplier: bottomHeightRatio),
            bottomView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
