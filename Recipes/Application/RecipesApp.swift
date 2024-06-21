import SwiftUI
import DomainMock
import Domain
import SearchScreen

@main
struct RecipesApp: App {
    var body: some Scene {
        WindowGroup {
            let repository = RandomRecipesRepositoryMock()
            let viewModel = SearchRecipesViewModel(repository: repository)
            SearchRecipesView(viewModel: viewModel)
        }
    }
}
