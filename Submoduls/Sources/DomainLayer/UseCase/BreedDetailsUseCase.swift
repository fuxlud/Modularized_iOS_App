import Foundation

public protocol BreedDetailsUseCaseProtocol { //MARK: Is class indeed needed?
    func getBreedDetails(breedName: String) async throws -> [BreedDetailsEntity]
}

public typealias FavoritingBreedDetailsUseCaseProtocol = BreedDetailsUseCaseProtocol & FavoritingUseCaseProtocol

public struct BreedDetailsUseCase: FavoritingBreedDetailsUseCaseProtocol  {
    private let repository: any BreedDetailsRepositoryProtocol

    public init(repository: any BreedDetailsRepositoryProtocol) {
        self.repository = repository
    }

    public func getBreedDetails(breedName: String) async throws -> [BreedDetailsEntity] {
        try await repository.getBreedDetails(breedName: breedName)
    }
    
    public func toggleLiking(breedDetailsEntity: BreedDetailsEntity) {
        repository.toggleLiking(breedDetailsEntity: breedDetailsEntity)
    }
}
