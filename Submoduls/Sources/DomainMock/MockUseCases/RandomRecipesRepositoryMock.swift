import Domain

public struct RandomRecipesRepositoryMock: RandomRecipesRepositoryProtocol {
    public func getRandomRecipes() async throws -> [Domain.RecipeEntity] {
        return RecipeEntity.mock
    }
    
    public init() {}
}
