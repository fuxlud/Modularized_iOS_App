import Domain

public struct MockRecipesFetcher: RecipesFetcher {
    
    public func fetch() async throws -> [Recipe] {
        return Recipe.mock
    }
    
    public init() {}
}
