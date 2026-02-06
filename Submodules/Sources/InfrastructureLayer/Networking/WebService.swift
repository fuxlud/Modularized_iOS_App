import Foundation

public typealias NetworkResponseCompletion = (_ result: Result<Any, Error>) -> Void

public protocol WebServiceProtocol: Sendable {
    var router: NetworkRouterProtocol! { get set }
}

public struct WebService: Sendable {
    public var router: NetworkRouterProtocol!

    public init(router: NetworkRouterProtocol = NetworkRouter()) {
        self.router = router
    }
}
