import Foundation

public protocol FavoritesManagerProtocol {
    func toggleLiking(breedDetails: BreedDetailsDTO) async
    func isLiked(breedDetails: BreedDetailsDTO) async -> Bool
    func fatchFavorites() async -> Set<BreedDetailsDTO>
}

public actor FavoritesManager: FavoritesManagerProtocol {
    
    public static let shared = FavoritesManager()
    
    private(set) var favoriteBreeds: Set<BreedDetailsDTO> = []
    private let persistence: PersistenceProtocol
    
    public init(persistence: PersistenceProtocol = UserDefaults()) {
        self.persistence = persistence
        Task {
            await loadFavoritesFromPersistence()
        }
    }
    
    public func toggleLiking(breedDetails: BreedDetailsDTO) async {
        if breedDetails.isFavorite {
            favoriteBreeds.insert(breedDetails)
        } else {
            favoriteBreeds.remove(breedDetails)
        }
        
        updatePersistence()
    }
    public func isLiked(breedDetails: BreedDetailsDTO) async -> Bool {
        favoriteBreeds.contains(breedDetails)
    }
    
    private func updatePersistence() {
        do {
            let favoriteBreedsEncoded = try JSONEncoder().encode(favoriteBreeds)
            persistence.set(favoriteBreedsEncoded, forKey: String(describing: FavoritesManager.self))
        } catch {}
    }
    
    private func loadFavoritesFromPersistence() {
        if let favoriteBreedsEncoded = persistence.data(forKey: String(describing: FavoritesManager.self))
        {
            do {
                let decoder = JSONDecoder()
                favoriteBreeds = try decoder.decode(Set<BreedDetailsDTO>.self, from: favoriteBreedsEncoded)
            } catch {}
        }
    }
    
    public func fatchFavorites() async -> Set<BreedDetailsDTO> {
        return favoriteBreeds
    }
}
