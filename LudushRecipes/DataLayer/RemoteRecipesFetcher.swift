import Foundation
import Alamofire

struct RemoteRecipesFetcher: RecipesFetcher {
    
    func fetch() async throws -> [Recipe] {
        let request = RecipesRequest()
        let recipesResponce = try await request.execute()
        let recipes = recipesResponce.recipes
        return recipes
    }
}

struct RecipesRequest {
    typealias ResponseType = RecipeResponse
    
    func execute() async throws -> ResponseType {
        let components = makeURLComponents(theKey: "44048404-dc035e463240cbbdc9c23e45c", 
                                           query: "yellow+flowers",
                                           imageType: "photo")
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }

        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, method: .get).responseDecodable(of: ResponseType.self) { response in
                switch response.result {
                case .success(let value):
                    continuation.resume(returning: value)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    private func makeURLComponents(theKey: String, query: String, imageType: String) -> URLComponents {
        
        var components = URLComponents()
        components.scheme = NetworkScheme.https.rawValue
        components.host = NetworkHost.pixabay.rawValue
        components.path = EndPoint.api.rawValue
        components.queryItems = [
            URLQueryItem(name: QueryParameter.key.rawValue, value: theKey),
            URLQueryItem(name: QueryParameter.query.rawValue, value: query),
            URLQueryItem(name: QueryParameter.imageType.rawValue, value: imageType)
        ]
        return components
    }
}



