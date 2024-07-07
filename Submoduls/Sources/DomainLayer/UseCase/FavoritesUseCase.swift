import Foundation

public protocol FetchFavoritesUseCaseProtocol {
    func fatchFavorites() async -> [BreedDetailsEntity]
}

public struct FetchFavoritesUseCase: FetchFavoritesUseCaseProtocol {
    private let repository: any BreedDetailsRepositoryProtocol

    public init(repository: any BreedDetailsRepositoryProtocol) {
        self.repository = repository
    }

    public func fatchFavorites() async -> [BreedDetailsEntity] {
        await repository.fatchFavorites()
    }
}
