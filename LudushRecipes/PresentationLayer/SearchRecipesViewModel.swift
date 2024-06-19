import Foundation
import SwiftUI
import Models
import Domain

@MainActor
class SearchRecipesViewModel: ObservableObject {
    @Published private(set) var recipes = [Recipe]()
    private let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
    }

    func loadRecipes() async throws {
        do {
            let recipes = try await repository.fetchRecipes()
            self.recipes = recipes
        } catch {
            print(error)
        }
    }
}
