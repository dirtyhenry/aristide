import Foundation

/**
 * An object that displays a secured text area in your interface.
 */
class PasswordField: TextField {
    override init(label: String, placeholder: String?, value: String?) {
        super.init(label: label, placeholder: placeholder, value: value)
        innerTextField.isSecureTextEntry = true
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
