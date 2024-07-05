import SwiftUI
import Domain
import DesignSystem

public struct DetailsScreen: View {
    
    var viewModel: DetailsScreenViewModel
    
    public init(viewModel: DetailsScreenViewModel) {
        self.viewModel = viewModel
    }
    
    let tileSize: CGFloat = 100
    let spacing: CGFloat = 20

    public var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [ .init(.adaptive( minimum: tileSize ), spacing: spacing)], spacing: spacing) {
                    if let breedDetailsViewModels = viewModel.state.data {
                        ForEach(breedDetailsViewModels) { breedDetailsViewModel in
                            
                            DetailsCard(viewModel: breedDetailsViewModel, tileSize: tileSize)
                        }
                    }
                }
                .padding(spacing)
            }
            .navigationTitle(viewModel.title)
            .navigationBarTitleDisplayMode(.large)
            .alert(isPresented: .constant(viewModel.state.error != nil)) {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.state.error ?? "Unknown error"),
                    dismissButton: .default(Text("OK"))
                )
            }
            .task {
                await viewModel.dispatch(.onAppear)
            }
        }
    }
}
