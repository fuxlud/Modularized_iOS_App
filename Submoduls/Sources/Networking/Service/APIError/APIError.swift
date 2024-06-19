import Foundation

public enum APIError: Error, Equatable {
    public static func == (lhs: APIError, rhs: APIError) -> Bool {
        switch (lhs, rhs) {
        case (.network(let lhsError), .network(let rhsError)):
            return self.areEqual(lhsError, rhsError)
        case (.decoding(let lhsError), .decoding(let rhsError)):
            return self.areEqual(lhsError, rhsError)
        case (.encoding(let lhsError), .encoding(let rhsError)):
            return self.areEqual(lhsError, rhsError)
        case (.error(let lhsError), .error(let rhsError)):
            return self.areEqual(lhsError, rhsError)
        default: return false
        }
    }

    public static func areEqual(_ lhs: Error, _ rhs: Error) -> Bool {
        return lhs.reflectedString == rhs.reflectedString
    }

    case network(error: Error)
    case decoding(error: Error)
    case encoding(error: Error)
    case error(error: Error)
    case notFound
}

public extension Error {
    var reflectedString: String {
        return String(reflecting: self)
    }
}
