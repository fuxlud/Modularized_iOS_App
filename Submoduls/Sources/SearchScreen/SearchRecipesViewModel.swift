import Foundation
import SwiftUI
import Domain

@MainActor
public class SearchRecipesViewModel: ObservableObject {
    @Published private(set) var recipes = [RecipeEntity]()
    private let repository: Repository
    
    public init(repository: Repository) {
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
