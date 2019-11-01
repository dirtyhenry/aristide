@testable import client_ios
import SnapshotTesting
import XCTest

class LabelTests: XCTestCase {
    let snapshotSize = CGSize(width: 320.0, height: 60.0)
    let padding = Padding(top: 0.0, bottom: 0.0, leading: 0.0, trailing: 0.0)

    func testDefaultState() {
        let label = Label(text: "Heading - Ink")
        let wrapper = label.wrapInView(size: snapshotSize, padding: padding)
        assertSnapshot(matching: wrapper, as: .image)
    }

    func testCaptionHighlightedState() {
        let label = Label(text: "Caption - Highlighted", textStyle: .captionHighlighted)
        let wrapper = label.wrapInView(size: snapshotSize, padding: padding)
        assertSnapshot(matching: wrapper, as: .image)
    }
}
