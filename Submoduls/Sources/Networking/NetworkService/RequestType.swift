import Foundation

public enum RequestError: Swift.Error {
    case badlyFormattedResponse
    case mockRouterFailure
}

public protocol RequestTypeProtocol {
    associatedtype ResponseType: Decodable

    var request: Request { get }
}

public extension RequestTypeProtocol {
    func execute(on router: NetworkRouterProtocol) async throws -> Any {
        let data = try await router.request(request)
        
        if let responseData = data, // String(data: data!, encoding: .utf8)
           let decodedData = try? JSONDecoder().decode(ResponseType.self, from: responseData) {
            return decodedData

        } else {
            throw RequestError.badlyFormattedResponse
        }
    }
}
