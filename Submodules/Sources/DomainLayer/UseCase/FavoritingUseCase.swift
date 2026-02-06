import Foundation

public protocol FavoritingUseCaseProtocol: Sendable {
    func toggleLiking(breedDetailsEntity: BreedDetailsEntity)
}

public struct FavoritingUseCase: FavoritingUseCaseProtocol, Sendable {
    private let repository: any BreedDetailsRepositoryProtocol & Sendable

    public init(repository: any BreedDetailsRepositoryProtocol & Sendable) {
        self.repository = repository
    }
    
    public func toggleLiking(breedDetailsEntity: BreedDetailsEntity) {
        repository.toggleLiking(breedDetailsEntity: breedDetailsEntity)
    }
}
