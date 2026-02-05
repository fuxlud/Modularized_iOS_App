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
        
        guard let responseData = data else {
            throw RequestError.badlyFormattedResponse
        }

        do {
            return try JSONDecoder().decode(ResponseType.self, from: responseData)
        } catch {
            let responseString = String(data: responseData, encoding: .utf8) ?? "<non-utf8 response>"
            print("Decoding failed for \(ResponseType.self). Response body:")
            print(responseString)
            throw RequestError.badlyFormattedResponse
        }
    }
}
