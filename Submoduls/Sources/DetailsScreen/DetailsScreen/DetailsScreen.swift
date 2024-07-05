import SwiftUI
import Domain
import DesignSystem

public struct DetailsScreen: View {
    
    var viewModel: DetailsScreenViewModel
    
    public init(viewModel: DetailsScreenViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [.init(.fixed(100)), .init(.fixed(100)), .init(.fixed(100))]) {
                    if let breedDetailsViewModels = viewModel.state.data {
                        ForEach(breedDetailsViewModels) { breedDetailsViewModel in
                            DetailsCard(viewModel: breedDetailsViewModel)
                        }
                    }
                }
                .padding()
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
