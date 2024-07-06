import Foundation

public protocol FetchFavoritesUseCaseProtocol { //MARK: Is use case classes indeed needed?
    func fatchFavorites() async -> [BreedDetailsEntity]
}

public typealias FavoritesUseCaseProtocol = FetchFavoritesUseCaseProtocol & FavoritingUseCaseProtocol

public struct FavoritesUseCase: FetchFavoritesUseCaseProtocol & FavoritingUseCaseProtocol {
    private let repository: any BreedDetailsRepositoryProtocol

    public init(repository: any BreedDetailsRepositoryProtocol) {
        self.repository = repository
    }

    public func fatchFavorites() async -> [BreedDetailsEntity] {
        await repository.fatchFavorites()
    }

    
    public func toggleLiking(breedDetailsEntity: BreedDetailsEntity) {
        repository.toggleLiking(breedDetailsEntity: breedDetailsEntity)
    }
}
