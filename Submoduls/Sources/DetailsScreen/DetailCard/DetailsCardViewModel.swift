import Foundation
import Domain

@Observable public class DetailsCardViewModel: ObservableObject, Identifiable {
    private let imageDetails: ImageDetailsEntity
    public let id = UUID()
    
    public init(imageDetails: ImageDetailsEntity) {
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
