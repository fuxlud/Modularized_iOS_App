import Domain

public struct MockRecipesFetcher: RecipesFetcher {
    
    public func fetch() async throws -> [RecipeEntity] {
        return RecipeEntity.mock
    }
    
    public init() {}
}
