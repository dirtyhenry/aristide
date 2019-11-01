@testable import client_ios
import SnapshotTesting
import XCTest

class PrimaryButtonTests: XCTestCase {
    let snapshotSize = CGSize(width: 320.0, height: 60.0)
    let padding = Padding(top: 8.0, leading: 8.0, trailing: 8.0)

    func testDefaultState() {
        let primaryButton = PrimaryButton(title: "OK")
        let wrapper = primaryButton.wrapInView(size: snapshotSize, padding: padding)
        assertSnapshot(matching: wrapper, as: .image)
    }
}
