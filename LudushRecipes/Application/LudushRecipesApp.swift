import SwiftUI
import DomainMock
import Domain
import SearchScreen

@main
struct LudushRecipesApp: App {
    var body: some Scene {
        WindowGroup {
            let mockRecipesFetcher = MockRecipesFetcher()
            let repository = Repository(recipesFetcher: mockRecipesFetcher)
            let viewModel = SearchRecipesViewModel(repository: repository)
            SearchRecipesView(viewModel: viewModel)
        }
    }
}
