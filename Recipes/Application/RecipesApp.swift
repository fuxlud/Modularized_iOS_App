import SwiftUI
import Domain
import SearchScreen
import Networking
import Data
@main

struct RecipesApp: App {
    var body: some Scene {
        WindowGroup {
            let repository = RandomRecipesRepository(service: WebService())
            let viewModel = SearchRecipesViewModel(repository: repository)
            SearchRecipesView(viewModel: viewModel)
        }
    }
}
