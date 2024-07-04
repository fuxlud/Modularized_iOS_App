import Foundation
import Domain
import Networking

protocol BreedDetailsService {
    func getBreedDetails(breed: inout BreedDTO) async throws
}

extension WebService: BreedDetailsService {
    func getBreedDetails(breed: inout BreedDTO) async throws {
        let request = BreedImagesRequest(breed: breed)
        
        let result = try await request.execute(on: router)
        
        if let imagesContainer = result as? BreedImagesResponse {
            var imagesDetails = imagesContainer.imagesDetails
            
            breed.breedImages = imagesDetails

        } else {
            throw APIError.notFound
        }
    }
}

struct BreedImagesRequest: RequestTypeProtocol {
    typealias ResponseType = BreedImagesResponse

    let breed: BreedDTO
    
    var request: Request {
        var components = URLComponents()
        components.scheme = NetworkScheme.https.rawValue
        components.host = NetworkHost.dogs.rawValue
        components.path = String(format: EndPoint.breedImages.rawValue, breed.name)
        let path = components.url?.absoluteString ?? ""

        return Request(path: path, method: .get)
    }
}
