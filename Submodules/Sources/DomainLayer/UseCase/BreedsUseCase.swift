import Foundation

public protocol BreedsUseCaseProtocol: Sendable {
    func getAllBreeds() async throws -> [BreedEntity]
}

public struct BreedsUseCase: BreedsUseCaseProtocol, Sendable {
    private let repository: any BreedsRepositoryProtocol & Sendable

    public init(repository: any BreedsRepositoryProtocol & Sendable) {
        self.repository = repository
    }

    public func getAllBreeds() async throws -> [BreedEntity] {
        try await repository.getAllBreeds()
    }
}
