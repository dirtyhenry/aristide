import UIKit

final class Coordinator {
    let window = UIWindow(frame: UIScreen.main.bounds)

    var authToken: String?

    private func createLoginViewController() -> LoginViewController {
        if #available(iOS 13, *) {
            return LoginViewControllerCombine()
        } else {
            return LoginViewControllerKVC()
        }
    }
    
    init() {
        let loginViewController = createLoginViewController()
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
