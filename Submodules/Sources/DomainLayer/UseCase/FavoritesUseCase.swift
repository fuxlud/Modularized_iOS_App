import Foundation
@preconcurrency import Combine

public protocol FetchFavoritesUseCaseProtocol: Sendable {
    func fetchFavorites() async -> [BreedDetailsEntity]
    var itemsPublisher: AnyPublisher<[BreedDetailsEntity], Never> { get }
}

public struct FetchFavoritesUseCase: FetchFavoritesUseCaseProtocol, Sendable {
    private let repository: any BreedDetailsRepositoryProtocol & Sendable

    public init(repository: any BreedDetailsRepositoryProtocol & Sendable) {
        self.repository = repository
    }

    public func fetchFavorites() async -> [BreedDetailsEntity] {
        await Array(repository.fetchFavorites())
    }
    
    public var itemsPublisher: AnyPublisher<[BreedDetailsEntity], Never> {
        repository.itemsPublisher
            .map { items in
                items.filter { $0.isFavorite }
            }
            .eraseToAnyPublisher()
    }
}
