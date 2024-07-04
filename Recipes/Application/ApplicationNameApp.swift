import SwiftUI
import Domain
import RecipesList
import Networking
import Data
@main

struct ApplicationNameApp: App {
    var body: some Scene {
        WindowGroup {
            let repository = RandomRecipesRepository(service: WebService())
            let useCase = RandomRecipesUseCase(repository: repository)
            let viewModel = RecipesViewModel(randomRecipesUseCase: useCase)
            RecipesView(viewModel: viewModel) //testing bitrise
        }
    }
}
