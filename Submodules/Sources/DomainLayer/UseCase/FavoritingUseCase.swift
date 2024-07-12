import Foundation

public protocol FavoritingUseCaseProtocol {
    func toggleLiking(breedDetailsEntity: BreedDetailsEntity)
}

public struct FavoritingUseCase: FavoritingUseCaseProtocol {
    private let repository: any BreedDetailsRepositoryProtocol

    public init(repository: any BreedDetailsRepositoryProtocol) {
        self.repository = repository
    }
    
    public func toggleLiking(breedDetailsEntity: BreedDetailsEntity) {
        repository.toggleLiking(breedDetailsEntity: breedDetailsEntity)
    }
}
