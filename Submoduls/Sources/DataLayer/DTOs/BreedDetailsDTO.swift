import Foundation

public struct BreedDetailsDTO: Codable {
    public let url: URL
    public var breedName = ""
    
    public init(url: URL) {
        self.url = url
    }
}

extension BreedDetailsDTO: Equatable {
    public static func == (lhs: BreedDetailsDTO, rhs: BreedDetailsDTO) -> Bool {
        return lhs.url == rhs.url
    }
}

struct BreedImagesResponse: Decodable {
    var imagesDetails: [BreedDetailsDTO]
    
    enum CodingKeys: String, CodingKey {
        case urlStrings = "message"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let urlStrings = try container.decode([String].self, forKey: .urlStrings)
        
        var fetchedImagesDetails: [BreedDetailsDTO] = []
        for urlString in urlStrings {
            if let url = URL(string: urlString) {
                let imageDetails = BreedDetailsDTO(url: url)
                fetchedImagesDetails.append(imageDetails)
            }
        }
        
        imagesDetails = fetchedImagesDetails
    }
}
