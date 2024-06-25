import SwiftUI
import Domain
import DesignSystem

public struct RecipeCard: View {
    @ObservedObject var viewModel: RecipeViewModel
    private let imageWidth = 110.0
    private let cellHeight = 130.0
    
    public var body: some View {
        VStack {
            if let imageUrl = viewModel.imageUrl {
                CacheAsyncImage(
                    url: imageUrl
                ) { phase in
                    switch phase {
                    case .success(let image):
                        HStack {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: imageWidth)
                        }
                    case .failure(let error):
                        ErrorView(error: error)
                        Circle()
                    case .empty:
                        HStack {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .red))
                            Spacer()
                        }
                    @unknown default:
                        Image(systemName: "questionmark")
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: cellHeight)
                .padding()
                .listRowSeparator(.hidden)
            }

            VStack(alignment: .leading) {
                Text(viewModel.title)
                    .font(.headline)
                    .lineLimit(2)
                Text("\(viewModel.servings) | \(viewModel.readyInMinutes)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding([.leading, .trailing, .bottom])
        }
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: Color(.black).opacity(0.2), radius: 5, x: 0, y: 5)
    }
}
//
//struct RecipeCard_Previews: PreviewProvider {
//    static var previews: some View {
//        let recipeMock = RecipeEntity.mock.first
//        let viewModel = RecipeViewModel(recipe: recipeMock!)
//        
//        return RecipeCard(viewModel: viewModel)
//            .previewLayout(.sizeThatFits)
//    }
//}
