import SwiftUI
import DomainLayer
import PresentationLayer_DesignSystem

public struct BreedImageView: View {
    private var viewModel: BreedImageViewModel
    private let tileSize: CGFloat
    
    public init(viewModel: BreedImageViewModel, tileSize: CGFloat) {
        self.viewModel = viewModel
        self.tileSize = tileSize
    }
    
    public var body: some View {
        Group {
            if let imageUrl = viewModel.imageUrl {
                ZStack {
                    URLImage(imageUrl)
                        .frame(width: tileSize, height: tileSize)
                    FavoriteButton(isOn: viewModel.isFavorite,
                                   action: { viewModel.likeButtonTapped() } )
                }
                .frame(width: tileSize, height: tileSize)
            }
        }
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: Color(.black).opacity(0.2), radius: 5, x: 0, y: 5)
    }
}

struct DetailsCard_Preview: PreviewProvider {
    static var previews: some View {
        let breedDetails = BreedDetailsEntity.mock.first!
        let useCase = FavoritingUseCaseMock(breedDetailsEntity: breedDetails)
        let viewModel = BreedImageViewModel(breedDetails: breedDetails, favoritingUseCase: useCase)
        
        return BreedImageView(viewModel: viewModel, tileSize: 100)
            .previewLayout(.sizeThatFits)
    }
}
