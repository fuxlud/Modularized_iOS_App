import Foundation
import DomainLayer

@Observable public class DetailsCardViewModel: ObservableObject, Identifiable {
    private var imageDetails: BreedDetailsEntity
    public let id = UUID()
    
    public init(imageDetails: BreedDetailsEntity) {
        self.imageDetails = imageDetails
    }
    
    var imageUrl: URL? {
        imageDetails.url
    }
    
    var isFavorite: Bool {
        return imageDetails.isFavorite
    }
    
    func likeButtonTapped() {
        let isFavoriteBeforeTap = imageDetails.isFavorite
        print(isFavoriteBeforeTap)
        imageDetails.isFavorite.toggle()
    }
}

extension DetailsCardViewModel: Equatable {
    public static func == (lhs: DetailsCardViewModel, rhs: DetailsCardViewModel) -> Bool {
      return lhs.id == rhs.id
    }
}
