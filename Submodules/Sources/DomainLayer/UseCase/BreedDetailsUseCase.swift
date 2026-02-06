import Foundation

public protocol BreedDetailsUseCaseProtocol: Sendable {
    func getBreedDetails(breedName: String) async throws -> [BreedDetailsEntity]
}

public struct BreedDetailsUseCase: BreedDetailsUseCaseProtocol, Sendable {
    private let repository: any BreedDetailsRepositoryProtocol & Sendable
    
    public init(repository: any BreedDetailsRepositoryProtocol & Sendable) {
        self.repository = repository
    }
    
    public func getBreedDetails(breedName: String) async throws -> [BreedDetailsEntity] {
        async let breedDetailsTask = repository.getRemoteBreedDetails(breedName: breedName)
        async let favoritesTask = repository.fetchFavorites()
        
        var breedDetails = try await breedDetailsTask
        let favorites = await favoritesTask
        
        for i in 0..<breedDetails.count {
            if favorites.contains(breedDetails[i]) {
                breedDetails[i].isFavorite = true
            }
        }
        return breedDetails
    }
}
