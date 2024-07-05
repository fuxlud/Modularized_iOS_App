import List
import SwiftUI
import DomainLayer

@main
struct CardPreviewApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                List {
                    BreedView(viewModel: BreedViewModel(breed: BreedEntity.mock.first!))
                    
                }
            }
        }
    }
}
