import SwiftUI
import DomainLayer
import PresentationLayer_DesignSystem

public struct DetailsCard: View {
    private var viewModel: DetailsCardViewModel
    private let tileSize: CGFloat
    
    public init(viewModel: DetailsCardViewModel, tileSize: CGFloat) {
        self.viewModel = viewModel
        self.tileSize = tileSize
    }
    
    public var body: some View {
        ZStack {
            Group {
                if let imageUrl = viewModel.imageUrl {
                    URLImage(imageUrl)
                        .frame(width: tileSize, height: tileSize)
                        .listRowSeparator(.hidden)
                }
            }
            .background(Color.white)
            .cornerRadius(8)
            .shadow(color: Color(.black).opacity(0.2), radius: 5, x: 0, y: 5)
            
            favoriteButton
        }
    }
    
    var favoriteButton: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                  ()
                }) {
                  Image(systemName: "star")
                    .font(.system(size: 24))
                    .foregroundColor(.white)
                }
            }
            .padding(10)
            Spacer()
        }
        .padding(5)
    }
}

struct DetailsCard_Preview: PreviewProvider {
    static var previews: some View {
        let breedDetails = BreedDetailsEntity.mock.first
        let viewModel = DetailsCardViewModel(imageDetails: breedDetails!)
        
        return DetailsCard(viewModel: viewModel, tileSize: 100)
            .previewLayout(.sizeThatFits)
    }
}
