import Foundation

public struct ImageDetailsDTO: Codable {
    public let url: URL
    public var breedName = ""
    
    public init(url: URL) {
        self.url = url
    }
}

extension ImageDetailsDTO: Equatable {
    public static func == (lhs: ImageDetailsDTO, rhs: ImageDetailsDTO) -> Bool {
        return lhs.url == rhs.url
    }
}

struct BreedImagesResponse: Decodable {
    var imagesDetails: [ImageDetailsDTO]
    
    enum CodingKeys: String, CodingKey {
        case urlStrings = "message"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let urlStrings = try container.decode([String].self, forKey: .urlStrings)
        
        var fetchedImagesDetails: [ImageDetailsDTO] = []
        for urlString in urlStrings {
            if let url = URL(string: urlString) {
                let imageDetails = ImageDetailsDTO(url: url)
                fetchedImagesDetails.append(imageDetails)
            }
        }
        
        imagesDetails = fetchedImagesDetails
    }
}
