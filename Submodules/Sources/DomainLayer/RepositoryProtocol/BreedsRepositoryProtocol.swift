import Foundation

public protocol BreedsRepositoryProtocol: Sendable {
    func getAllBreeds() async throws -> [BreedEntity]
}
