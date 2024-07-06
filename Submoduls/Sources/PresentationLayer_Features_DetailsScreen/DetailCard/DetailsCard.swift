import SwiftUI
import DomainLayer
import PresentationLayer_DesignSystem
import DataLayer // TODO: Should move to Dependency Container. Is here becouse of FavoritesManager creation

public struct DetailsCard: View {
    private var viewModel: DetailsCardViewModel
    private let tileSize: CGFloat
    private let padding: CGFloat = 3
    
    public init(viewModel: DetailsCardViewModel, tileSize: CGFloat) {
        self.viewModel = viewModel
        self.tileSize = tileSize
    }
    
    public var body: some View {
        Group {
            if let imageUrl = viewModel.imageUrl {
                ZStack {
                    URLImage(imageUrl)
                        .frame(width: tileSize, height: tileSize)
                    favoriteButton
                }
                .frame(width: tileSize, height: tileSize)
            }
        }
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: Color(.black).opacity(0.2), radius: 5, x: 0, y: 5)
    }
    
    var favoriteButton: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    viewModel.likeButtonTapped()
                }) {
                    Group {
                        if viewModel.isFavorite {
                            Image(systemName: "heart.fill")
                        } else {
                            Image(systemName: "heart")
                        }
                    }
                    .font(.system(size: 28, weight: .medium))
                    .foregroundColor(.white)
                }
            }
            .padding(padding)
        }
        .padding(padding)
    }
}

struct DetailsCard_Preview: PreviewProvider {
    static var previews: some View {
        let breedDetails = BreedDetailsEntity.mock.first!
        let useCase = BreedDetailsUseCaseMock()
        let viewModel = DetailsCardViewModel(breedDetails: breedDetails, breedDetailsUseCase: useCase)
        
        return DetailsCard(viewModel: viewModel, tileSize: 100)
            .previewLayout(.sizeThatFits)
    }
}


struct DetailsViewWithData_Preview: PreviewProvider {
    static var previews: some View {

        let useCase = BreedDetailsUseCaseMock(breedDetails: BreedDetailsEntity.mock)
        let viewModel = DetailsScreenViewModel(breedName: "", breedDetailsUseCase: useCase)

        DetailsScreen(viewModel: viewModel)
    }
}
