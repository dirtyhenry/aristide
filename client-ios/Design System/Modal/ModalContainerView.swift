import UIKit

/**
 * A class providing a way to display a view *designed to be full-screen*.
 *
 * ## What does *designed to be full-screen* means?
 *
 * It means that, **ideally**, some items are anchored at the top of the view,
 * and other items are anchored to the bottom of the view.
 *
 * Under not ideal situation, like a user having set their preferred font size to be big
 * enough that an overflow becomes unavoidable, this view then behave as a scroll view.
 */
class ModalContainerView: UIScrollView {
    let contentView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        super.addSubview(contentView)

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(
                equalTo: contentLayoutGuide.topAnchor,
                constant: Theme.Spacing.s7.pointValue
            ),
            contentView.leadingAnchor.constraint(
                equalTo: contentLayoutGuide.leadingAnchor,
                constant: Theme.Spacing.s4.pointValue
            ),
            contentView.bottomAnchor.constraint(
                equalTo: contentLayoutGuide.bottomAnchor,
                constant: -Theme.Spacing.s7.pointValue
            ),
            contentView.trailingAnchor.constraint(
                equalTo: contentLayoutGuide.trailingAnchor,
                constant: -Theme.Spacing.s4.pointValue
            ),
            contentView.widthAnchor.constraint(
                equalTo: widthAnchor,
                constant: -2 * Theme.Spacing.s4.pointValue
            ),
            contentView.heightAnchor.constraint(
                greaterThanOrEqualTo: heightAnchor,
                constant: -2 * Theme.Spacing.s7.pointValue
            )
        ])
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override class var requiresConstraintBasedLayout: Bool {
        return true
    }

    override func addSubview(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
    }
}
