import Foundation

public protocol BreedsUseCaseProtocol {
    func getAllBreeds() async throws -> [BreedEntity]
}

public struct BreedsUseCase: BreedsUseCaseProtocol {
    private let repository: any BreedsRepositoryProtocol

    public init(repository: any BreedsRepositoryProtocol) {
        self.repository = repository
    }

    public func getAllBreeds() async throws -> [BreedEntity] {
        try await repository.getAllBreeds()
    }
}
