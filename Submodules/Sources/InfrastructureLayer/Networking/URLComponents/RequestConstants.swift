public enum RequestKeys: String {
    case error
    case authorization = "Authorization"
    case contentType = "Content-Type"
    case result
    case number
}

public enum RequestConstantValues: String {
    case noTokenAvailable = "NO_TOKEN_AVAILABLE"
    case bearer = "Bearer"
    case json = "application/json"
    case trueValue = "true"
}
