import Foundation
import Domain
import Networking

public struct RandomRecipesRepository: RandomRecipesRepositoryProtocol {
    private let service: NetworkingService

    public init(service: NetworkingService) {
        self.service = service
    }

    public func getRandomRecipes() async throws -> [RecipeEntity] {
        guard let request = GetRandomRecipesRequest().generateURLRequest() else {
            throw APIError.notFound
        }
        
        let dto: [RecipeDTO] = try await service.send(request)
        return dto.map { $0.toRecipeEntity() }
    }
}
