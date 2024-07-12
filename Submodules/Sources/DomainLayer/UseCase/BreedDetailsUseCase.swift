import Foundation

public protocol BreedDetailsUseCaseProtocol {
    func getBreedDetails(breedName: String) async throws -> [BreedDetailsEntity]
}

public struct BreedDetailsUseCase: BreedDetailsUseCaseProtocol {
    private let repository: BreedDetailsRepositoryProtocol
    
    public init(repository: BreedDetailsRepositoryProtocol) {
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
