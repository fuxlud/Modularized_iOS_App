import Foundation

class Repository {
    let recipesFetcher: RecipesFetcher
    
    init(recipesFetcher: RecipesFetcher) {
        self.recipesFetcher = recipesFetcher
    }
    
    func fetchRecipes() async throws -> [Recipe] {
        let recipes = try await recipesFetcher.fetch()
        return recipes
    }
}
