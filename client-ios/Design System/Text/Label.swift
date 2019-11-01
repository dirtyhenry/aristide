import UIKit

/**
 * A view that displays one or more lines of read-only text.
 */
class Label: UILabel {
    init(text: String, textStyle: Theme.TextStyle = .headingInk) {
        super.init(frame: .zero)

        textAlignment = .center
        numberOfLines = 0
        self.textStyle = textStyle
        self.text = text

        translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
