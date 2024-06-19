import Foundation

public struct GetRandomRecipesRequest: GetAPIRequest {
    public typealias ResponseType = [RecipeDTO]

    public init() {}

    public var endpoint: String {
        ""
    }
    public var queryItems: [URLQueryItem] {
        guard let apiKey =  Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            return []
        }
        return [
            URLQueryItem(name: "api_key", value: apiKey)
        ]
    }
}
