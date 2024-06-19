import Models

struct MockRecipesFetcher: RecipesFetcher {
    
    func fetch() async throws -> [Recipe] {
        return Recipe.mockData
    }
}
