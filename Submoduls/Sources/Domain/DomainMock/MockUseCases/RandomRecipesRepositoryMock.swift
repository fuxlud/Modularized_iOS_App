import Domain

public struct RandomRecipesUseCaseMock: RandomRecipesUseCaseProtocol {
    
    let recipes: [Domain.RecipeEntity]?
    let error: Error?
    
    public func getRandomRecipes() async throws -> [Domain.RecipeEntity] {
        if let error {
            throw error
        }
        return recipes ?? []
    }
    
    public init(recipes: [Domain.RecipeEntity]? = nil, error: Error? = nil) {
        self.recipes = recipes
        self.error = error
    }
}
