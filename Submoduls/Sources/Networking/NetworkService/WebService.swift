import Foundation

public typealias NetworkResponseCompletion = (_ result: Result<Any, Error>) -> Void

public protocol WebServiceProtocol {
    var router: NetworkRouterProtocol! { get set }
}

public struct WebService {
    var router: NetworkRouterProtocol!

    public init(router: NetworkRouterProtocol = NetworkRouter()) {
        self.router = router
    }
}
