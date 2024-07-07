import Foundation

public protocol FetchFavoritesUseCaseProtocol {
    func fetchFavorites() async -> [BreedDetailsEntity]
}

public struct FetchFavoritesUseCase: FetchFavoritesUseCaseProtocol {
    private let repository: any BreedDetailsRepositoryProtocol

    public init(repository: any BreedDetailsRepositoryProtocol) {
        self.repository = repository
    }

    public func fetchFavorites() async -> [BreedDetailsEntity] {
        await Array(repository.fetchFavorites())
    }
}
