import Foundation

extension String {
    var isBlank: Bool {
        return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var isPresent: Bool {
        return !isBlank
    }

    static func isBlank(_ aString: String) -> Bool {
        return aString.isBlank
    }

    static func isPresent(_ aString: String) -> Bool {
        return !isBlank(aString)
    }
}

extension Optional where Wrapped == String {
    var isBlank: Bool {
        if let unwrapped = self {
            return unwrapped.isBlank
        } else {
            return true
        }
    }

    var isPresent: Bool {
        return !isBlank
    }

    static func isBlank(_ anOptional: Optional) -> Bool {
        return anOptional.isBlank
    }

    static func isPresent(_ anOptional: Optional) -> Bool {
        return !isBlank(anOptional)
    }
}
