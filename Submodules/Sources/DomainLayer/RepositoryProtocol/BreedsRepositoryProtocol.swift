import Foundation

public protocol BreedsRepositoryProtocol {
    func getAllBreeds() async throws -> [BreedEntity]
}
