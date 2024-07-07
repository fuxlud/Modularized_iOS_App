import Foundation

public protocol BreedDetailsUseCaseProtocol {
    func getBreedDetails(breedName: String) async throws -> [BreedDetailsEntity]
}

public struct BreedDetailsUseCase: BreedDetailsUseCaseProtocol {
    private let repository: any BreedDetailsRepositoryProtocol

    public init(repository: any BreedDetailsRepositoryProtocol) {
        self.repository = repository
    }

    public func getBreedDetails(breedName: String) async throws -> [BreedDetailsEntity] {
        try await repository.getBreedDetails(breedName: breedName)
    }
}
