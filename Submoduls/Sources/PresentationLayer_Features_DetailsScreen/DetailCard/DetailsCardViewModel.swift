import Foundation
import DomainLayer
import DataLayer

@Observable public class DetailsCardViewModel: ObservableObject, Identifiable {
    private var imageDetails: BreedDetailsEntity
    private let favoritesManager: FavoritesManagerProtocol
    public let id = UUID()
    
    public init(imageDetails: BreedDetailsEntity, favoritesManager: FavoritesManagerProtocol) {
        self.imageDetails = imageDetails
        self.favoritesManager = favoritesManager
    }
    
    var imageUrl: URL? {
        imageDetails.url
    }
    
    var isFavorite: Bool {
        return imageDetails.isFavorite
    }
    
    func likeButtonTapped() {
        imageDetails.isFavorite.toggle()
        Task {
            await favoritesManager.toggleLiking(breedDetails: imageDetails.toBreedDetailsDTO())
        }
    }
}

extension DetailsCardViewModel: Equatable {
    public static func == (lhs: DetailsCardViewModel, rhs: DetailsCardViewModel) -> Bool {
      return lhs.id == rhs.id
    }
}
