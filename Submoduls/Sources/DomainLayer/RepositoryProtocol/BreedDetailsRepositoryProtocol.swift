import Foundation

public protocol BreedDetailsRepositoryProtocol {
    func getBreedDetails(breedName: String) async throws -> [BreedDetailsEntity]
}
