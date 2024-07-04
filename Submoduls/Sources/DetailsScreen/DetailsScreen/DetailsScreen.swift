import SwiftUI
import Domain
import DesignSystem

public struct BreedsView: View {
    
    var viewModel: DetailsScreenViewModel
    
    public init(viewModel: DetailsScreenViewModel) {
        self.viewModel = viewModel
    }
    
    private var flexibleColumns: [GridItem] {
        Array(repeating: GridItem(.flexible(minimum: 100, maximum: 200)), count: 3)
    }
    
    public var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: flexibleColumns, spacing: 20) {
                    if let breedDetailsViewModels = viewModel.state.data {
                        ForEach(breedDetailsViewModels) { breedDetailsViewModel in
                            DetailsCard(viewModel: breedDetailsViewModel)
                                .frame(height: 100)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("To Change")
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
