import UIKit

protocol TextFieldDelegate: AnyObject {
    func textFieldShouldReturn(_ textField: TextField) -> Bool
}

/**
 * An object that displays an editable text area in your interface.
 *
 * ## Limitations
 *
 * This view is not accessible yet. Please refer to [FRONT-803](https://youtrack.margobank.net/issue/FRONT-803) for details.
 */
class TextField: UIView {
    private struct StateDependentAttributes {
        let borderColor: Theme.Color
        let labelLabelStyle: Theme.TextStyle
        let labelLabelOffset: CGFloat
        let innerTextFieldHidden: Bool
    }

    // MARK: - Validating and Handling Edits

    weak var delegate: TextFieldDelegate?

    var value: String? {
        get { return innerTextField.text }
        set {
            innerTextField.text = newValue
            updateFromState()
        }
    }

    // MARK: - Subviews

    let labelLabel = UILabel()
    let innerTextField = UITextField()

    private var isEditing: Bool = false {
        didSet {
            if isEditing != oldValue {
                updateFromState()
            }
        }
    }

    private var labelCenterConstraint: NSLayoutConstraint?

    // MARK: - Creating a TextField object

    init(label: String, placeholder: String?, value: String?) {
        super.init(frame: .zero)

        layer.borderWidth = 1.0
        layer.cornerRadius = Theme.Metric.borderRadius.pointValue

        labelLabel.text = label

        innerTextField.textStyle = .body2Ink
        innerTextField.attributedPlaceholder = NSAttributedString(
            string: placeholder ?? "",
            attributes: [NSAttributedString.Key.foregroundColor: Theme.Color.textSubdued.uiColor]
        )
        innerTextField.text = value
        innerTextField.delegate = self

        addSubview(labelLabel)
        addSubview(innerTextField)

        translatesAutoresizingMaskIntoConstraints = false
        labelLabel.translatesAutoresizingMaskIntoConstraints = false
        innerTextField.translatesAutoresizingMaskIntoConstraints = false

        labelCenterConstraint = labelLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0)
        NSLayoutConstraint.activate([
            labelLabel.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: Theme.Spacing.s2.pointValue
            ),
            labelLabel.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -Theme.Spacing.s2.pointValue
            ),
            labelCenterConstraint!,

            innerTextField.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: Theme.Spacing.s2.pointValue
            ),
            innerTextField.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -Theme.Spacing.s2.pointValue
            ),
            innerTextField.centerYAnchor.constraint(
                equalTo: centerYAnchor,
                constant: Theme.Spacing.s1.pointValue
            ),

            heightAnchor.constraint(equalToConstant: 52.0)
        ])

        updateFromState()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(_:))))
    }

    private func attributesFromState() -> StateDependentAttributes {
        if isEditing {
            return StateDependentAttributes(
                borderColor: .inputBorderActive,
                labelLabelStyle: .captionHighlighted,
                labelLabelOffset: -10.0,
                innerTextFieldHidden: false
            )
        } else {
            return StateDependentAttributes(
                borderColor: .inputBorder,
                labelLabelStyle: value.isBlank ? .body2Subdued : .captionSubdued,
                labelLabelOffset: value.isBlank ? 0 : -10.0,
                innerTextFieldHidden: value.isBlank
            )
        }
    }

    private func updateFromState() {
        let newAttributes = attributesFromState()

        layoutIfNeeded()
        UIView.animate(withDuration: 0.2) {
            self.layer.borderColor = newAttributes.borderColor.uiColor.cgColor
            self.labelLabel.textStyle = newAttributes.labelLabelStyle

            if self.labelCenterConstraint?.constant != newAttributes.labelLabelOffset {
                self.labelCenterConstraint?.constant = newAttributes.labelLabelOffset
                self.superview?.layoutIfNeeded()
            }

            self.innerTextField.isHidden = newAttributes.innerTextFieldHidden
        }
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Events handler

    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            innerTextField.becomeFirstResponder()
        }
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 52.0)
    }
}

extension TextField: UITextFieldDelegate {
    // MARK: - UITextFieldDelegate

    func textFieldDidBeginEditing(_: UITextField) {
        isEditing = true
    }

    func textFieldDidEndEditing(_: UITextField) {
        isEditing = false
    }

    func textFieldShouldReturn(_: UITextField) -> Bool {
        guard let delegate = delegate else {
            return true
        }

        return delegate.textFieldShouldReturn(self)
    }
}
