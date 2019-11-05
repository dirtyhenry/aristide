import Combine
import Foundation

@available(iOS 13.0, *)
class LoginViewModelCombine: ObservableObject {
    // MARK: Inputs

    @Published var email: String?
    @Published var password: String?

    // MARK: Outputs

    private var authenticateDTOPublisher: AnyPublisher<AuthenticateDTO?, Never> {
        return Publishers.CombineLatest($email, $password)
            .map { arg in
                let (email, password) = arg
                return AuthenticateDTO(email: email, clearPassword: password)
            }
            .eraseToAnyPublisher()
    }

    var submitButtonEnabledPublisher: AnyPublisher<Bool, Never> {
        return authenticateDTOPublisher
            .map { authenticateDTO in
                return authenticateDTO != nil
        }
            .eraseToAnyPublisher()
    }

    init() {
        #if DEBUG_LOGIN_CREDENTIALS
            if ProcessInfo.processInfo.environment["IS_TEST_TARGET"] == nil {
                email = DebugConfig.userEmail
                password = DebugConfig.userPassword
            }
        #endif
    }

    func submit() {
        dump(email)
        dump(password)
    }
}

class LoginViewModelKVC: NSObject {
    // MARK: Inputs

    @objc dynamic var email: String? {
        didSet {
            updateSubmitButtonEnabled()
        }
    }
    @objc dynamic var password: String? {
        didSet {
            updateSubmitButtonEnabled()
        }
    }
    
    @objc dynamic var submitButtonEnabled: Bool
    
    private var emailObservation: NSKeyValueObservation?
    private var passwordObservation: NSKeyValueObservation?
    
    // MARK: Outputs

    override init() {
        submitButtonEnabled = false

        #if DEBUG_LOGIN_CREDENTIALS
            if ProcessInfo.processInfo.environment["IS_TEST_TARGET"] == nil {
                email = DebugConfig.userEmail
                password = DebugConfig.userPassword
            }
        #endif
    }
    
    private func updateSubmitButtonEnabled() {
        submitButtonEnabled = AuthenticateDTO(email: email, clearPassword: password) != nil
    }

    func submit() {
        dump(email)
        dump(password)
    }
}
