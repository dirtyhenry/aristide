@testable import client_ios
import SnapshotTesting
import XCTest

class LoginViewControllerTests: XCTestCase {
    func testSnapshot() {
        let sut = LoginViewController()
        assertLocalizedSnapshot(matching: sut)
    }
}
