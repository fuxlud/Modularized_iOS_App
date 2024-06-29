import Foundation

public protocol RandomRecipesUseCaseProtocol {
    func getRandomRecipes() async throws -> [RecipeEntity]
}

public struct RandomRecipesUseCase: RandomRecipesUseCaseProtocol {
    private let repository: any RandomRecipesRepositoryProtocol

    public init(repository: any RandomRecipesRepositoryProtocol) {
        self.repository = repository
    }

    public func getRandomRecipes() async throws -> [RecipeEntity] {
        try await repository.getRandomRecipes()
    }
}
