public enum ErrorEntity: Error {
    case general
    case tlsInspection

    public var description: String {
        switch self {
        case .general:
            return "Oops, something went wrong"
        case .tlsInspection:
            return "Secure connection failed. If you're on a corporate VPN with TLS inspection, install the organization's root CA or switch networks."
        }
    }

    public static func from(_ error: Error) -> ErrorEntity {
        if let urlError = error as? URLError {
            switch urlError.code {
            case .serverCertificateUntrusted,
                 .serverCertificateHasUnknownRoot:
                return .tlsInspection
            default:
                break
            }
        }
        return .general
    }
}
