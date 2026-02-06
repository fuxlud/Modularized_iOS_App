@MainActor
public protocol DIContainerProtocol {
  func register<Component>(type: Component.Type, component: Component)
  func resolve<Component>(type: Component.Type) -> Component?
}

@MainActor
public final class DIContainer: DIContainerProtocol {
  public static let shared = DIContainer()
  private init() {}
  private var components: [ObjectIdentifier: Any] = [:]

  public func register<Component>(type: Component.Type, component: Component) {
    components[ObjectIdentifier(type)] = component
  }

  public func resolve<Component>(type: Component.Type) -> Component? {
    components[ObjectIdentifier(type)] as? Component
  }
}
