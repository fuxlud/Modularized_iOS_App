import SwiftUI
import DomainLayer
import PresentationLayer_DesignSystem
import PresentationLayer_Features_DetailsScreen

public struct BreedsView: View {
    
    let tileSize: CGFloat = 150
    let spacing: CGFloat = 20
    
    var viewModel: BreedsViewModel
    private var selectedBreedViewModel: BreedImagesViewModel?
    
    public init(viewModel: BreedsViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [ .init(.adaptive( minimum: tileSize ), spacing: spacing)], spacing: spacing) {
                    if let breedsViewModels = viewModel.state.data {
                        ForEach(breedsViewModels) { breedViewModel in
                            NavigationLink(
                                destination: BreedImagesScreen(viewModel: viewModel.detailsScreenViewModel(for: breedViewModel)),
                                label: {
                                    BreedView(viewModel: breedViewModel)
                                        .frame(height: tileSize)
                                }
                            )
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("All 🐶 Breeds")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Text("Favorites: \(viewModel.favoriteCount)")
                        .font(.subheadline)
                        .padding()
                }
            }
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
}
