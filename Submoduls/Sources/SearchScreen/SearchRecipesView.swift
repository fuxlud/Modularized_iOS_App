import SwiftUI
import Domain
import DomainMock
import Data
import Networking
import DesignSystem

public struct SearchRecipesView: View {
    
    @StateObject var viewModel: SearchRecipesViewModel
    
    public init(viewModel: SearchRecipesViewModel) {
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
        let viewModel = SearchRecipesViewModel(repository: repositoryMock)
        SearchRecipesView(viewModel: viewModel)
    }
}
