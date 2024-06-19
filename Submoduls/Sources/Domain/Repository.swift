import Foundation

public  class Repository {
    let recipesFetcher: RecipesFetcher
    
    public init(recipesFetcher: RecipesFetcher) {
        self.recipesFetcher = recipesFetcher
    }
    
    public func fetchRecipes() async throws -> [Recipe] {
        let recipes = try await recipesFetcher.fetch()
        return recipes
    }
}
