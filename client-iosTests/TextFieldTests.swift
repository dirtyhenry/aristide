@testable import client_ios
import SnapshotTesting
import XCTest

class TextFieldTests: XCTestCase {
    let snapshotSize = CGSize(width: 320.0, height: 52.0)
    let padding = Padding(top: 0.0, leading: 0.0, trailing: 0.0)

    func testDefaultState() {
        let textField = TextField(label: "Prénom", placeholder: "Placeholder", value: nil)
        let wrapper = textField.wrapInView(size: snapshotSize, padding: padding)
        assertSnapshot(matching: wrapper, as: .image)
    }

    func testPlaceholderState() {
        let textField = TextField(label: "Prénom", placeholder: "Placeholder", value: nil)
        let wrapper = textField.wrapInView(size: snapshotSize, padding: padding)
        textField.innerTextField.becomeFirstResponder()
        assertSnapshot(matching: wrapper, as: .image)
    }

    func testTypingState() {
        let textField = TextField(label: "Prénom", placeholder: "Placeholder", value: "Nicolas")
        let wrapper = textField.wrapInView(size: snapshotSize, padding: padding)
        textField.innerTextField.becomeFirstResponder()
        assertSnapshot(matching: wrapper, as: .image)
    }

    func testCompletedState() {
        let textField = TextField(label: "Prénom", placeholder: "Placeholder", value: "Nicolas")
        let wrapper = textField.wrapInView(size: snapshotSize, padding: padding)
        assertSnapshot(matching: wrapper, as: .image)
    }
}
