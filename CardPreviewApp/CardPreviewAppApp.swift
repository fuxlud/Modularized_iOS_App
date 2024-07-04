import List
import SwiftUI
import Domain

@main
struct CardPreviewAppApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                List {
                    Card(viewModel: RecipeViewModel(recipe: RecipeEntity.mock.first!))
                }
            }
        }
    }
}
