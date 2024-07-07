import Combine
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
    
    public func getRemoteBreedDetails(breedName: String) async throws -> [BreedDetailsEntity] {
        let breedDetailsDTOs: [BreedDetailsDTO] = try await service.getBreedDetails(breedName: breedName)
        return breedDetailsDTOs.map { $0.toBreedDetailsEntity() }
    }
    
    public func fetchFavorites() async -> Set<BreedDetailsEntity> {
        await Set(favoritesManager.fetchFavorites().map { $0.toBreedDetailsEntity() })
    }
    
    public func toggleLiking(breedDetailsEntity: BreedDetailsEntity) {
        Task {
            await favoritesManager.toggleLiking(breedDetails: breedDetailsEntity.toBreedDetailsDTO())
        }
    }
    
    public var itemsPublisher: AnyPublisher<[BreedDetailsEntity], Never> {
        favoritesManager.favoriteBreedsPublisher
            .map { favoriteBreeds in
                favoriteBreeds.map { $0.toBreedDetailsEntity() }
            }
            .eraseToAnyPublisher()
    }
}
