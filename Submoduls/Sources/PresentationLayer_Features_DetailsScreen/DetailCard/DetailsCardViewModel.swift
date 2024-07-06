import Foundation
import DomainLayer
import DataLayer

@Observable public class DetailsCardViewModel: ObservableObject, Identifiable {
    private var breedDetails: BreedDetailsEntity
    private var breedDetailsUseCase: BreedDetailsUseCaseProtocol
    public let id = UUID()
    
    public init(breedDetails: BreedDetailsEntity,
                breedDetailsUseCase: BreedDetailsUseCaseProtocol) {
        self.breedDetails = breedDetails
        self.breedDetailsUseCase = breedDetailsUseCase
    }
    
    var imageUrl: URL? {
        breedDetails.url
    }
    
    var isFavorite: Bool {
        return breedDetails.isFavorite
    }
    
    func likeButtonTapped() {
        breedDetails.isFavorite.toggle()
        breedDetailsUseCase.toggleLiking(breedDetailsEntity: breedDetails)
    }
}

extension DetailsCardViewModel: Equatable {
    public static func == (lhs: DetailsCardViewModel, rhs: DetailsCardViewModel) -> Bool {
      return lhs.id == rhs.id
    }
}
