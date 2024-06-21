import Foundation

public protocol DataRequestProtocol {
    var request: Request { get }
}

public extension DataRequestProtocol {
    func execute(on router: NetworkRouterProtocol) async throws -> Data? {
        return try await router.request(request)
    }
}
