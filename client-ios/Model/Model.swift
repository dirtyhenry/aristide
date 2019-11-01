import Combine
import Foundation
import UIKit

struct AuthenticateDTO: Codable {
    let email: String
    let password: String

    init(email: String, clearPassword: String) {
        self.email = email
        password = clearPassword.data(using: .utf8)!.base64EncodedString()
    }

    init?(email: String?, clearPassword: String?) {
        guard let email = email, let clearPassword = clearPassword else { return nil }
        guard email.isPresent, clearPassword.isPresent else { return nil }

        self.init(email: email, clearPassword: clearPassword)
    }
}

struct SessionDTO: Codable {
    
}
