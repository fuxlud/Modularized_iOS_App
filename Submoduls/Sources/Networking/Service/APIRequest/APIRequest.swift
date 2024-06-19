import Foundation

public protocol APIRequest {
    associatedtype ResponseType: Decodable

    var cachePolicy: NSURLRequest.CachePolicy { get }
    var endpoint: String { get }
    var queryItems: [URLQueryItem] { get }
    func generateURLRequest() -> URLRequest?
    var authorization: Authorization? { get set }
}

public extension APIRequest {
    func createURL() -> URL? {
        guard let baseUrl = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String else { return nil }
        var components = URLComponents(string: baseUrl + endpoint)
        components?.queryItems = queryItems

        guard let validComponents = components, let url = validComponents.url else {
            return nil
        }

        return url
    }

    var cachePolicy: NSURLRequest.CachePolicy {
        return .useProtocolCachePolicy
    }

    var queryItems: [URLQueryItem] {
        return []
    }

    var authorization: Authorization? {
        get { return nil }
        set { _ = newValue }
    }
}
