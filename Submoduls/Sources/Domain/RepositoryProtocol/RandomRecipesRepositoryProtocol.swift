import Foundation

public protocol RandomRecipesRepositoryProtocol {
    func getRandomRecipes() async throws -> [RecipeEntity]
}
