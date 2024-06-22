import SwiftUI
import Domain
import RecipesScreen
import Networking
import Data
import DomainMock
@main

struct RecipesApp: App {
    var body: some Scene {
        WindowGroup {
            let repository = RandomRecipesRepository(service: WebService())
//            let repository = RandomRecipesRepositoryMock()
            let viewModel = RecipesViewModel(repository: repository)
            RecipesView(viewModel: viewModel)
        }
    }
}
