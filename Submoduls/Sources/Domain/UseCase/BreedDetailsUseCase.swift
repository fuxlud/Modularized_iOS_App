import Foundation

public protocol BreedDetailsUseCaseProtocol {
    func getBreedDetails() async throws -> [ImageDetailsEntity]
}

public struct BreedDetailsUseCase: BreedDetailsUseCaseProtocol {
    private let repository: any BreedDetailsRepositoryProtocol

    public init(repository: any BreedDetailsRepositoryProtocol) {
        self.repository = repository
    }

    public func getBreedDetails() async throws -> [ImageDetailsEntity] {
        try await repository.getBreedDetails()
    }
}
