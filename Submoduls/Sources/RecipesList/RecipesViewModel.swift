import Foundation
import SwiftUI
import Domain

@MainActor
public class RecipesViewModel: ObservableObject {
    @Published private(set) var recipeViewModels = [RecipeViewModel]()
    private let randomRecipesUseCase: RandomRecipesUseCaseProtocol
    
    public init(randomRecipesUseCase: RandomRecipesUseCaseProtocol) {
        self.randomRecipesUseCase = randomRecipesUseCase
    }

    func loadRecipes() async throws {
        do {
            let recipes = try await randomRecipesUseCase.getRandomRecipes()
            self.recipeViewModels = recipes.map { RecipeViewModel(recipe: $0) }
        } catch {
            print(error)
        }
    }
}
