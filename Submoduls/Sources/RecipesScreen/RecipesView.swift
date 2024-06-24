import SwiftUI
import Domain
import DomainMock
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
                    ForEach(viewModel.recipeViewModels) { recipeViewModel in
                        RecipeCard(viewModel: recipeViewModel)
                    }
                }
                .padding()
            }
            .navigationTitle("Random Recipes")
            .navigationBarTitleDisplayMode(.large)
            .task {
                try? await viewModel.loadRecipes()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let repositoryMock = RandomRecipesRepositoryMock()
        let viewModel = RecipesViewModel(repository: repositoryMock)
        RecipesView(viewModel: viewModel)
    }
}
