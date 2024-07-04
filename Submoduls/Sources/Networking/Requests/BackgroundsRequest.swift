import Foundation

public extension WebService {
    func getAllBreeds() async throws -> [BreedDTO] {
        let request = BreedRequest()

        let result = try await request.execute(on: router)

        if let breedsContainer = result as? BreedsResponseDTO {
            let breeds = breedsContainer.breeds.breeds.sorted{ $0.name < $1.name }
            return breeds
        } else {
            throw APIError.notFound
        }
    }
}

struct BreedRequest: RequestTypeProtocol {
    typealias ResponseType = BreedsResponseDTO

    var request: Request {
        var components = URLComponents()
        components.scheme = NetworkScheme.https.rawValue
        components.host = NetworkHost.dogs.rawValue
        components.path = EndPoint.allBreeds.rawValue
        let path = components.url?.absoluteString ?? ""

        return Request(path: path, method: .get)
    }
}
