import Foundation

public protocol FavoritesManagerProtocol {
    func like(breedDetails: BreedDetailsDTO) async
    func unlike(breedDetails: BreedDetailsDTO) async
    func isLiked(breedDetails: BreedDetailsDTO) async -> Bool
}

public actor FavoritesManager: FavoritesManagerProtocol {
        
    private(set) var favoriteBreeds: Set<BreedDetailsDTO> = []
    private let persistence: PersistenceProtocol
    
    init(persistence: PersistenceProtocol) {
        self.persistence = persistence
        Task {
            await loadFavoritesFromLocalStorage()
        }
    }
    
    public func like(breedDetails: BreedDetailsDTO) async {
        favoriteBreeds.insert(breedDetails)
        updateLocalStorage()
    }
    
    public func unlike(breedDetails: BreedDetailsDTO) async {
        favoriteBreeds.remove(breedDetails)
        updateLocalStorage()
    }
    
    public func isLiked(breedDetails: BreedDetailsDTO) async -> Bool {
        favoriteBreeds.contains(breedDetails)
    }
    
    private func updateLocalStorage() {
        do {
            let favoriteBreedsEncoded = try JSONEncoder().encode(favoriteBreeds)
            persistence.set(favoriteBreedsEncoded, forKey: String(describing: FavoritesManager.self))
        } catch {}
    }
    
    private func loadFavoritesFromLocalStorage() {
        if let favoriteBreedsEncoded = persistence.data(forKey: String(describing: FavoritesManager.self))
        {
            do {
                let decoder = JSONDecoder()
                favoriteBreeds = try decoder.decode(Set<BreedDetailsDTO>.self, from: favoriteBreedsEncoded)
            } catch {}
        }
    }
}
