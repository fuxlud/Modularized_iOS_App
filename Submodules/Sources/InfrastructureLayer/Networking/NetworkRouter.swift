import Foundation

enum DataRequestError: Error {
    case noURL
}

public protocol NetworkRouterProtocol {
    func request(_ request: RequestProtocol) async throws -> Data?
}

public struct NetworkRouter: NetworkRouterProtocol {
    public init() {}

    public func request(_ request: RequestProtocol) async throws -> Data? {
        return try await sendRequest(request)
    }

    private func sendRequest(_ request: RequestProtocol) async throws -> Data {
        let urlRequest = try buildRequest(from: request)
        NetworkLogger.log(request: urlRequest)

        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.waitsForConnectivity = true

        let session = URLSession(configuration: sessionConfig)

        let (data, _) = try await session.data(fromURLRequest: urlRequest)
        return data
    }

    private func buildRequest(from request: RequestProtocol) throws -> URLRequest {
        guard let path = request.path else {
            throw APIError.invalidURL
        }
        guard let url = URL(string: path) else {
            throw APIError.invalidURL
        }

        var urlRequest = URLRequest(url: url)

        let authHeader = ["x-api-key": "e4ddff29844d4ea9af16fbc3ee57128a"] // In a real app would be stored in the Keychain

        urlRequest.allHTTPHeaderFields = authHeader
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body

        if let params = request.parameters {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
        }

        urlRequest.setValue(RequestConstantValues.json.rawValue, forHTTPHeaderField: RequestKeys.contentType.rawValue)

        return urlRequest
    }
}
