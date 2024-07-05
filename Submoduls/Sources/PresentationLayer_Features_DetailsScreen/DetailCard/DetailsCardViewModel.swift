import Foundation
import DomainLayer

@Observable public class DetailsCardViewModel: ObservableObject, Identifiable {
    private let imageDetails: BreedDetailsEntity
    public let id = UUID()
    
    public init(imageDetails: BreedDetailsEntity) {
        self.imageDetails = imageDetails
    }
    
    var imageUrl: URL? {
        imageDetails.url
    }
}

extension DetailsCardViewModel: Equatable {
    public static func == (lhs: DetailsCardViewModel, rhs: DetailsCardViewModel) -> Bool {
      return lhs.id == rhs.id
    }
}
