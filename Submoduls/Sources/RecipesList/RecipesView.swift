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
//                    ForEach(viewModel.recipeViewModels) { recipeViewModel in
//                        RecipeCard(viewModel: recipeViewModel)
//                    }
                    ForEach(viewModel.state.recipes) { recipe in
                        let viewModel = RecipeViewModel(recipe: recipe)
                        RecipeCard(viewModel: viewModel)
                    }
                }
                .padding()
            }
            .navigationTitle("Random Recipes")
            .navigationBarTitleDisplayMode(.large)
            .toastView(toast: $viewModel.state.error)
            .task {
                await viewModel.dispatch(.onAppear)
            }
        }
    }
}
