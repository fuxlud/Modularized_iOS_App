import Foundation
@testable import Networking

struct MockRouter: NetworkRouterProtocol, Equatable {
    let jsonStub: String?

    func request(_: RequestProtocol) async throws -> Data? {
        if let jsonData = jsonStub?.data(using: .utf8, allowLossyConversion: false) {
            return jsonData
        } else {
            throw RequestError.mockRouterFailure
        }
    }
}
