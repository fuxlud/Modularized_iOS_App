import SwiftUI
import DomainLayer
import PresentationLayer_DesignSystem

public struct BreedImagesScreen: View {
    
    @StateObject var viewModel: BreedImagesViewModel
    
    public init( viewModel: @autoclosure @escaping () -> BreedImagesViewModel ) {
            _viewModel = StateObject(wrappedValue: viewModel())
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
                await viewModel.dispatch(.onAppear)
            }
        }
    }
}
