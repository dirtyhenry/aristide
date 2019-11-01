import Combine
import UIKit

protocol LoginViewControllerDelegate: AnyObject {
    func loginViewController(_ controller: LoginViewController,
                             didStartSession session: SessionDTO)
}

/**
 * A dumb login view controller.
 */
class LoginViewController: UIViewController {
    let viewModel: LoginViewModel

    weak var delegate: LoginViewControllerDelegate?

    // MARK: - Login form

    let heading = Label(text: t("auth.login.client.title"), textStyle: .headingInk)

    let emailInput = TextField(
        label: t("auth.login.email"),
        placeholder: t("auth.login.email"),
        value: nil
    )

    let passwordInput = PasswordField(
        label: t("auth.login.password"),
        placeholder: t("auth.login.password"),
        value: nil
    )

    let submitButton = PrimaryButton(title: t("auth.login.submit"))

    init(viewModel: LoginViewModel = LoginViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

        emailInput.value = viewModel.email
        emailInput.innerTextField.addTarget(self, action: #selector(emailChanged(_:)), for: .editingChanged)

        passwordInput.value = viewModel.password
        passwordInput.innerTextField.addTarget(self, action: #selector(passwordChanged(_:)), for: .editingChanged)

        _ = viewModel
            .submitButtonEnabledPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isEnabled, on: submitButton)
    }

    @IBAction func emailChanged(_ sender: UITextField) {
        viewModel.email = sender.text
    }

    @IBAction func passwordChanged(_ sender: UITextField) {
        viewModel.password = sender.text
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false

        submitButton.addTarget(self, action: #selector(onSubmit(_:)), for: .touchUpInside)

        view.addSubview(heading)
        view.addSubview(emailInput)
        view.addSubview(passwordInput)
        view.addSubview(submitButton)

        NSLayoutConstraint.activate([
            // Position heading
            heading.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 134.0),
            heading.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32.0),
            heading.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32.0),

            // Position emailInput
            emailInput.topAnchor.constraint(equalTo: heading.bottomAnchor, constant: 24.0),
            emailInput.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32.0),
            emailInput.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32.0),

            // Position passwordInput
            passwordInput.topAnchor.constraint(equalTo: emailInput.bottomAnchor, constant: 16.0),
            passwordInput.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32.0),
            passwordInput.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32.0),

            // Position submit button
            submitButton.topAnchor.constraint(equalTo: passwordInput.bottomAnchor, constant: 24.0),
            submitButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32.0),
            submitButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32.0)
        ])
    }

    @IBAction func onSubmit(_: Any) {
        viewModel.submit()
    }
}
