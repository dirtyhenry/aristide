@testable import client_ios
import SnapshotTesting
import XCTest

class PasswordFieldTests: XCTestCase {
    let snapshotSize = CGSize(width: 320.0, height: 52.0)
    let padding = Padding(top: 0.0, leading: 0.0, trailing: 0.0)

    func testDefaultState() {
        let passwordField = PasswordField(label: "Prénom", placeholder: "Placeholder", value: nil)
        let wrapper = passwordField.wrapInView(size: snapshotSize, padding: padding)
        assertSnapshot(matching: wrapper, as: .image)
    }

    func testPlaceholderState() {
        let passwordField = PasswordField(label: "Prénom", placeholder: "Placeholder", value: nil)
        let wrapper = passwordField.wrapInView(size: snapshotSize, padding: padding)
        passwordField.innerTextField.becomeFirstResponder()
        assertSnapshot(matching: wrapper, as: .image)
    }

    func testTypingState() {
        let passwordField = PasswordField(label: "Prénom", placeholder: "Placeholder", value: "Nicolas")
        let wrapper = passwordField.wrapInView(size: snapshotSize, padding: padding)
        passwordField.innerTextField.becomeFirstResponder()
        assertSnapshot(matching: wrapper, as: .image)
    }

    func testCompletedState() {
        let passwordField = PasswordField(label: "Prénom", placeholder: "Placeholder", value: "Nicolas")
        let wrapper = passwordField.wrapInView(size: snapshotSize, padding: padding)
        assertSnapshot(matching: wrapper, as: .image)
    }
}
