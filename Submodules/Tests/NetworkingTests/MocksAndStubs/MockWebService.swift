import Foundation
@testable import InfrastructureLayer

struct MockWebService: WebServiceProtocol {
    var router: NetworkRouterProtocol!
}
