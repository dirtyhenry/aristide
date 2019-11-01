import Foundation

/**
 * This enum provides a convenient way to access configuration values at runtime.
 *
 * Cf. https://nshipster.com/xcconfig/
 */
enum Configuration {
    enum Error: Swift.Error {
        case missingKey, invalidValue
    }

    static func validate() {
        guard let keys = Bundle.main.infoDictionary?.keys else {
            fatalError("couldn't find dictionary keys")
        }

        let debugOnlyKeys = keys.filter { $0 == "NSAppTransportSecurity" || $0.hasPrefix("DEBUG_") }
        #if DEBUG
            print("💁‍♂️ \(debugOnlyKeys.count) debug only config keys are being used.")
        #else
            if debugOnlyKeys.count > 0 {
                fatalError("Configuration check ⛔️ - debug keys are being used in a release build.")
            } else {
                print("Configuration check ✅")
            }
        #endif
    }

    fileprivate static func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey: key) else {
            throw Error.missingKey
        }

        switch object {
        case let value as T:
            return value
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            throw Error.invalidValue
        }
    }
}

// swiftlint:disable force_try
enum BackendConfig {
    static var scheme: String {
        return try! Configuration.value(for: "BACKEND_API_SCHEME")
    }

    static var host: String {
        return try! Configuration.value(for: "BACKEND_API_HOST")
    }

    static var port: Int? {
        return try? Configuration.value(for: "BACKEND_API_PORT")
    }
}

#if DEBUG
    enum DebugConfig {
        static var userEmail: String {
            return try! Configuration.value(for: "DEBUG_USER_EMAIL")
        }

        static var userPassword: String {
            return try! Configuration.value(for: "DEBUG_USER_PASSWORD")
        }
    }
#endif
// swiftlint:enable force_try
