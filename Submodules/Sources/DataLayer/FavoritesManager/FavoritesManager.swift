import Foundation
import Combine

public protocol FavoritesManagerProtocol {
    func toggleLiking(breedDetails: BreedDetailsDTO) async
    func isLiked(breedDetails: BreedDetailsDTO) async -> Bool
    func fetchFavorites() async -> Set<BreedDetailsDTO>
    var favoriteBreedsPublisher: AnyPublisher<Set<BreedDetailsDTO>, Never> { get }
}

public class FavoritesManager: FavoritesManagerProtocol {
    
    public static let shared = FavoritesManager()
    
    private var favoriteBreeds: Set<BreedDetailsDTO> = []
    private let persistence: PersistenceProtocol
    private let favoriteBreedsSubject = CurrentValueSubject<Set<BreedDetailsDTO>, Never>([])
    
    public init(persistence: PersistenceProtocol = UserDefaults()) {
        self.persistence = persistence
        Task {
            await loadFavoritesFromPersistence()
        }
    }
    
    public var favoriteBreedsPublisher: AnyPublisher<Set<BreedDetailsDTO>, Never> {
        return favoriteBreedsSubject.eraseToAnyPublisher()
    }
    
    public func toggleLiking(breedDetails: BreedDetailsDTO) async {
        if breedDetails.isFavorite {
            favoriteBreeds.insert(breedDetails)
        } else {
            favoriteBreeds.remove(breedDetails)
        }
        
        favoriteBreedsSubject.send(favoriteBreeds)
        updatePersistence()
    }
    
    public func isLiked(breedDetails: BreedDetailsDTO) async -> Bool {
        return favoriteBreeds.contains(breedDetails)
    }
    
    private func updatePersistence() {
        do {
            let favoriteBreedsEncoded = try JSONEncoder().encode(favoriteBreeds)
            persistence.set(favoriteBreedsEncoded, forKey: String(describing: FavoritesManager.self))
        } catch {}
    }
    
    private func loadFavoritesFromPersistence() async {
        if let favoriteBreedsEncoded = persistence.data(forKey: String(describing: FavoritesManager.self)) {
            do {
                let decoder = JSONDecoder()
                favoriteBreeds = try decoder.decode(Set<BreedDetailsDTO>.self, from: favoriteBreedsEncoded)
                favoriteBreedsSubject.send(favoriteBreeds)
            } catch {}
        }
    }
    
    public func fetchFavorites() async -> Set<BreedDetailsDTO> {
        return favoriteBreeds
    }
}
