import Foundation

public protocol BreedDetailsRepositoryProtocol {
    func getRemoteBreedDetails(breedName: String) async throws -> [BreedDetailsEntity]
    func toggleLiking(breedDetailsEntity: BreedDetailsEntity) 
    func fetchFavorites() async -> Set<BreedDetailsEntity>
}
