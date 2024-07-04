import SwiftUI
import Domain
import DesignSystem

public struct DetailsCard: View {
    var viewModel: DetailsCardViewModel
    
    public init(viewModel: DetailsCardViewModel) {
        self.viewModel = viewModel
    }
    
    private let imageWidth = 110.0
    private let cellHeight = 130.0
    
    public var body: some View {
        Group {
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
        }
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: Color(.black).opacity(0.2), radius: 5, x: 0, y: 5)
    }
}
