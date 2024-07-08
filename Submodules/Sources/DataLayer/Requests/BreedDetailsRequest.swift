import Foundation
import DomainLayer
import Networking

protocol BreedDetailsService {
    func getBreedDetails(breedName: String) async throws -> [BreedDetailsDTO]
}

extension WebService: BreedDetailsService {
    func getBreedDetails(breedName: String) async throws -> [BreedDetailsDTO] {
        let request = BreedImagesRequest(breedName: breedName)
        
        let result = try await request.execute(on: router)
        
        if let imagesContainer = result as? BreedImagesResponse {
            return imagesContainer.imagesDetails
            
        } else {
            throw APIError.notFound
        }
    }
}

struct BreedImagesRequest: RequestTypeProtocol {
    typealias ResponseType = BreedImagesResponse

    let breedName: String
    
    var request: Request {
        var components = URLComponents()
        components.scheme = NetworkScheme.https.rawValue
        components.host = NetworkHost.dogs.rawValue
        components.path = String(format: EndPoint.breedImages.rawValue, breedName)
        let path = components.url?.absoluteString ?? ""

        return Request(path: path, method: .get)
    }
}
