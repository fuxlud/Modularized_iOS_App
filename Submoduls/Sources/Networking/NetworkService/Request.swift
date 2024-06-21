import Foundation

public protocol RequestProtocol {
    var path: String? { get }
    var method: HTTPMethod { get }
    var body: Data? { get }
    var parameters: [String: Any?]? { get }
    var headers: [String: String]? { get }
    var authorizationToken: String? { get }
}

public struct Request: RequestProtocol {
    public let path: String?
    public let method: HTTPMethod
    public let body: Data?
    public let parameters: [String: Any?]?
    public var headers: [String: String]?
    public var authorizationToken: String?

    public init(path: String?,
                method: HTTPMethod = .get,
                body: Data? = nil,
                parameters: [String: Any?]? = nil,
                headers: [String: String]? = nil,
                authorizationToken: String? = nil) {
        self.path = path
        self.method = method
        self.body = body
        self.parameters = parameters
        self.headers = headers
        self.authorizationToken = authorizationToken
    }
}
