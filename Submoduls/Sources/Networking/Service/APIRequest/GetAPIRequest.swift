import Foundation

public protocol GetAPIRequest: APIRequest {}

public extension GetAPIRequest {
    func generateURLRequest() -> URLRequest? {
        guard let url = createURL() else {
            return nil
        }
        var request = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: 60)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let authentication = authorization {
            request.setValue("Bearer \(authentication.accessToken)", forHTTPHeaderField: "Authorization")
        }
        return request
    }
}
