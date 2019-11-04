import Combine
import Foundation

class LoginViewModel: ObservableObject {
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
