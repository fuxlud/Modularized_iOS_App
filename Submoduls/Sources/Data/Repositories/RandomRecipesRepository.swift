import Foundation
import Domain
import Networking

public struct RandomRecipesRepository: RandomRecipesRepositoryProtocol {
    private let service: WebService

    public init(service: WebService) {
        self.service = service
    }

    public func getRandomRecipes() async throws -> [RecipeEntity] {
        let dto: [RecipeDTO] = try await service.getRandomRecipes(number: 5)
        return dto.map { $0.toRecipeEntity() }
    }
}
