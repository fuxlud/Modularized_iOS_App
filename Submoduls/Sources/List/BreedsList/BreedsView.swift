import SwiftUI
import Domain
import DesignSystem
import DetailsScreen

public struct BreedsView: View {
    
    var viewModel: BreedsViewModel
    @State private var selectedBreedViewModel: DetailsScreenViewModel?
    
    public init(viewModel: BreedsViewModel) {
        self.viewModel = viewModel
    }
    
    private var flexibleColumns: [GridItem] {
        Array(repeating: GridItem(.flexible(minimum: 100, maximum: 200)), count: 3)
    }
    
    public var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: flexibleColumns, spacing: 20) {
                    if let breedsViewModels = viewModel.state.data {
                        ForEach(breedsViewModels) { breedViewModel in
                            NavigationLink(
                                destination: DetailsScreen(viewModel: viewModel.detailsScreenViewModel(for: breedViewModel)),
                                label: {
                                    BreedView(viewModel: breedViewModel)
                                        .frame(height: 100)
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
