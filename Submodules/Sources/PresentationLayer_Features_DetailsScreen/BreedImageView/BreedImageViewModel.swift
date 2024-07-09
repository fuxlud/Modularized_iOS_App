import Foundation
import DomainLayer
import DataLayer

@Observable public class BreedImageViewModel: Identifiable {
    var breedDetails: BreedDetailsEntity
    private var favoritingUseCase: FavoritingUseCaseProtocol
    public let id = UUID()
    
    public init(breedDetails: BreedDetailsEntity,
                favoritingUseCase: FavoritingUseCaseProtocol) {
        self.breedDetails = breedDetails
        self.favoritingUseCase = favoritingUseCase
    }
    
    var imageUrl: URL? {
        breedDetails.url
    }
    
    var isFavorite: Bool {
        return breedDetails.isFavorite
    }
    
    func likeButtonTapped() {
        breedDetails.isFavorite.toggle()
        favoritingUseCase.toggleLiking(breedDetailsEntity: breedDetails)
    }
}

extension BreedImageViewModel: Equatable {
    public static func == (lhs: BreedImageViewModel, rhs: BreedImageViewModel) -> Bool {
      return lhs.id == rhs.id
    }
}
