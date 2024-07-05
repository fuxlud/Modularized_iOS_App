import SwiftUI
import Domain
import DesignSystem
import DetailsScreen

public struct BreedsView: View {
    
    let tileSize: CGFloat = 150
    let spacing: CGFloat = 20
    
    var viewModel: BreedsViewModel
    @State private var selectedBreedViewModel: DetailsScreenViewModel?
    
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
                                destination: DetailsScreen(viewModel: viewModel.detailsScreenViewModel(for: breedViewModel)),
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
            .navigationTitle("🐶 Breeds")
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
