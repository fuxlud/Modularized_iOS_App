import Foundation
@testable import Networking

struct MockWebService: WebServiceProtocol {
    var router: NetworkRouterProtocol!
}
