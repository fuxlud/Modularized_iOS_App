import Foundation

public extension WebService {
    func getRandomRecipes(number: Int) async throws -> [RecipeDTO] {
        let request = RandomRecipesRequest(number: number)

        let result = try await request.execute(on: router)

        if let recipesResponse = result as? RecipeResponseDTO {
           let recipes = recipesResponse.recipes    
            return recipes
        } else {
            throw APIError.notFound
        }
    }
}

struct RandomRecipesRequest: RequestTypeProtocol {
    typealias ResponseType = RecipeResponseDTO

    let number: Int

    var request: Request {
        var components = URLComponents()
        components.scheme = NetworkScheme.https.rawValue
        components.host = NetworkHost.spoonacular.rawValue
        components.path = EndPoint.recipes.rawValue
        components.queryItems = [
            URLQueryItem(name: RequestKeys.number.rawValue, value: String(number)),
            URLQueryItem(name: "apiKey", value: "e4ddff29844d4ea9af16fbc3ee57128a"),
            URLQueryItem(name: "includeNutrition", value: "false")
        ]

        let path = components.url?.absoluteString ?? ""
        return Request(path: path, method: .get)
    }
}
