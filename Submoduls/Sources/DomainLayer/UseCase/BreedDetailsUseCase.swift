import Foundation

public protocol BreedDetailsUseCaseProtocol { //MARK: Is class needed indeed?
    func getBreedDetails(breedName: String) async throws -> [BreedDetailsEntity]
    func toggleLiking(breedDetailsEntity: BreedDetailsEntity)
}

public struct BreedDetailsUseCase: BreedDetailsUseCaseProtocol {
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
