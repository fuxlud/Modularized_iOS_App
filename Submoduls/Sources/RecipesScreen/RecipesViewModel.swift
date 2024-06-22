import Foundation
import SwiftUI
import Domain
import DomainMock

@MainActor
public class RecipesViewModel: ObservableObject {
    @Published private(set) var recipeViewModels = [RecipeViewModel]()
    private let repository: RandomRecipesRepositoryProtocol
    
    public init(repository: RandomRecipesRepositoryProtocol) {
        self.repository = repository
    }

    func loadRecipes() async throws {
        do {
            let recipes = try await repository.getRandomRecipes()
            self.recipeViewModels = recipes.map { RecipeViewModel(recipe: $0) }
        } catch {
            print(error)
        }
    }
}
