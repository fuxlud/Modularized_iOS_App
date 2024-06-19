import Foundation

public protocol DeleteAPIRequest: APIRequest {
    func generateBody() -> Data?
}

public extension DeleteAPIRequest {
    func generateBody() -> Data? {
        return nil
    }
    
    func generateURLRequest() -> URLRequest? {
        guard let url = createURL() else {
            return nil
        }
        var request = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: 60)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let authentication = authorization {
            request.setValue("Bearer \(authentication.accessToken)", forHTTPHeaderField: "Authorization")
        }
        request.httpBody = generateBody()
        return request
    }
}
