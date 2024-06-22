import SwiftUI
import Domain
import SearchScreen
import Networking
import Data
import DomainMock
@main

struct RecipesApp: App {
    var body: some Scene {
        WindowGroup {
//            let repository = RandomRecipesRepository(service: WebService())
            let repository = RandomRecipesRepositoryMock()
            let viewModel = SearchRecipesViewModel(repository: repository)
            SearchRecipesView(viewModel: viewModel)
        }
    }
}
