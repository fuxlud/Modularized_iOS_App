import SwiftUI
import DomainLayer
import PresentationLayer_DesignSystem
import PresentationLayer_Features_DetailsScreen
public struct FavoritesView: View {
    
    var viewModel: FavoritesViewModel
    
    public init(viewModel: FavoritesViewModel) {
        self.viewModel = viewModel
    }
    
    let tileSize: CGFloat = 100
    let spacing: CGFloat = 20
    
    public var body: some View {
        ScrollView {
            LazyVGrid(columns: [ .init(.adaptive( minimum: tileSize ), spacing: spacing)], spacing: spacing) {
                if let breedDetailsViewModels = viewModel.state.data {
                    ForEach(breedDetailsViewModels) { breedDetailsViewModel in
                        
                        BreedImageView(viewModel: breedDetailsViewModel, tileSize: tileSize)
                    }
                }
            }
            .padding(spacing)
        }
        .navigationBarTitle(viewModel.title)
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: .constant(viewModel.state.error != nil)) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.state.error ?? "Unknown error"),
                dismissButton: .default(Text("OK"))
            )
        }
        .executeOnceOnAppear {
            Task {
                await viewModel.dispatch(.executeOnceOnAppear)
            }
        }
    }
}
