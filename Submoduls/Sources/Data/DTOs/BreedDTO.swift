import Foundation

public struct BreedDTO: Decodable {
    public let name: String
    public var breedImages: [BreedDetailsDTO] = []
    
    public init(name: String, breedImages: [BreedDetailsDTO] = []) {
        self.name = name
        self.breedImages = breedImages
    }
}
