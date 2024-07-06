import Foundation
import DomainLayer
import Networking

public struct BreedDetailsRepository: BreedDetailsRepositoryProtocol {
    
    private let service: WebService
    private let favoritesManager: FavoritesManagerProtocol
    public init(service: WebService, favoritesManager: FavoritesManagerProtocol) {
        self.service = service
        self.favoritesManager = favoritesManager
    }
    
    public func getBreedDetails(breedName: String) async throws -> [BreedDetailsEntity] {
        var breedDetailsDTOs: [BreedDetailsDTO] = try await service.getBreedDetails(breedName: breedName)
        for i in 0..<breedDetailsDTOs.count {
            if await favoritesManager.isLiked(breedDetails: breedDetailsDTOs[i]) {
                breedDetailsDTOs[i].isFavorite = true
            }
        }
        
        return breedDetailsDTOs.map { $0.toBreedDetailsEntity() }
    }
    
    public func toggleLiking(breedDetailsEntity: BreedDetailsEntity) {
        Task {
            await favoritesManager.toggleLiking(breedDetails: breedDetailsEntity.toBreedDetailsDTO())
        }
    }
}
