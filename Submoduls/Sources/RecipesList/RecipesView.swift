import SwiftUI
import Domain
import DesignSystem

public struct RecipesView: View {
    
    @StateObject var viewModel: RecipesViewModel
    
    public init(viewModel: RecipesViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    public var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    if let recipeViewModels = viewModel.state.data {
                      ForEach(recipeViewModels) { recipeViewModel in
                        RecipeCard(viewModel: recipeViewModel)
                      }
                    }
                }
                .padding()
            }
            .navigationTitle("Random Recipes")
            .navigationBarTitleDisplayMode(.large)
//            .toastView(toast: $viewModel.state.error)
            .task {
                await viewModel.dispatch(.onAppear)
            }
        }
    }
}
