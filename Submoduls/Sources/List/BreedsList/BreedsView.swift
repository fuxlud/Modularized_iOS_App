import SwiftUI
import Domain
import DesignSystem
import DetailsScreen

public struct BreedsView: View {
    
    var viewModel: BreedsViewModel
    @State private var selectedBreedViewModel: DetailsScreenViewModel? //TODO: Move to ViewModel
    @State private var showDetails = false //TODO: Move to ViewModel

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
                            BreedView(viewModel: breedViewModel)
                                .frame(height: 100)
                                .onTapGesture {
                                    let breedDetailsViewModel = viewModel.detailsScreenViewModel(for: breedViewModel)
                                    self.selectedBreedViewModel = breedDetailsViewModel
                                    self.showDetails = true
                                }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("🐶 Breeds")
            .navigationBarTitleDisplayMode(.large)
            .alert(isPresented: .constant(viewModel.state.error != nil)) {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.state.error ?? "Unknown error"),
                    dismissButton: .default(Text("OK"))
                )
            }
            .sheet(isPresented: $showDetails) {
                       if let selectedBreedViewModel = selectedBreedViewModel {
                           DetailsScreen(viewModel: selectedBreedViewModel)
                       }
                   }
            .task {
                await viewModel.dispatch(.onAppear)
            }
        }
    }
}
