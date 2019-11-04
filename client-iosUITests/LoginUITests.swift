import XCTest

class LoginUITests: XCTestCase {
    override func setUp() {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test.
        // Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
    }

    func testLogin() {
        let app = XCUIApplication()
        
        let emailField = app.textFields["Email"]
        emailField.tap()
        emailField.typeText("foo@bar.tld")
        
        let passwordField = app.secureTextFields["Password"]
        passwordField.tap()
        passwordField.typeText("bar")
        
        let submit = app.buttons["Login"]
        submit.tap()
    }
}
