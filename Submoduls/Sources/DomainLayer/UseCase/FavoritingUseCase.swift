import Foundation

public protocol FavoritingUseCaseProtocol { //MARK: Is Use case classes indeed needed?
    func toggleLiking(breedDetailsEntity: BreedDetailsEntity)
}

public struct FavoriteUseCase: FavoritingUseCaseProtocol {
    private let repository: any BreedDetailsRepositoryProtocol

    public init(repository: any BreedDetailsRepositoryProtocol) {
        self.repository = repository
    }
    
    public func toggleLiking(breedDetailsEntity: BreedDetailsEntity) {
        repository.toggleLiking(breedDetailsEntity: breedDetailsEntity)
    }
}
