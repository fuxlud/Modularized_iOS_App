import SwiftUI
import Domain
import DesignSystem

public struct RecipesView: View {
    
    var viewModel: RecipesViewModel
    
    public init(viewModel: RecipesViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    if let recipeViewModels = viewModel.state.data {
                        ForEach(recipeViewModels) { recipeViewModel in
                            Card(viewModel: recipeViewModel)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Random Recipes")
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
