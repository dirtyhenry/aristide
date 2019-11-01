import UIKit

final class Coordinator {
    let window = UIWindow(frame: UIScreen.main.bounds)

    var authToken: String?

    init() {
        let loginViewController = LoginViewController()
        loginViewController.delegate = self

        window.rootViewController = loginViewController
        window.makeKeyAndVisible()
    }
}

extension Coordinator: LoginViewControllerDelegate {
    func loginViewController(_: LoginViewController, didStartSession session: SessionDTO) {
        debugPrint("🎉 A session started")
    }
}
