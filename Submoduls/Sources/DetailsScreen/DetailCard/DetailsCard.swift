import SwiftUI
import Domain
import DesignSystem

public struct DetailsCard: View {
    var viewModel: DetailsCardViewModel
    
    public init(viewModel: DetailsCardViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        Group {
            if let imageUrl = viewModel.imageUrl {
                CacheAsyncImage(
                    url: imageUrl
                ) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                    case .failure(let error):
                        ErrorView(error: error)
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
                .listRowSeparator(.hidden)
            }
        }
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: Color(.black).opacity(0.2), radius: 5, x: 0, y: 5)
    }
}
