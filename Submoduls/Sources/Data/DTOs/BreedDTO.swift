import Foundation

public struct BreedDTO: Decodable {
    public let name: String
    public var breedImages: [ImageDetailsDTO] = []
    
    public init(name: String, breedImages: [ImageDetailsDTO] = []) {
        self.name = name
        self.breedImages = breedImages
    }
}
