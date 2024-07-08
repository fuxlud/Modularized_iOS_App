import Foundation

public struct BreedEntity {
    public let name: String
    public var breedImages: [BreedDetailsEntity] = []
    
    public init(name: String, breedImages: [BreedDetailsEntity] = []) {
        self.name = name
        self.breedImages = breedImages
    }
}

extension BreedEntity: Equatable {}
