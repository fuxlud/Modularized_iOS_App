import RecipesList
import SwiftUI
import DomainMock
import Domain

@main
struct RecipeCardPreviewAppApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                List {
                    RecipeCard(viewModel: RecipeViewModel(recipe: RecipeEntity.mock.first!))
                }
            }
        }
    }
}
