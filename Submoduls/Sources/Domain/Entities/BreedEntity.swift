import Foundation

public struct BreedEntity {
    public let name: String
    public var breedImages: [ImageDetailsEntity] = []
    
    public init(name: String, breedImages: [ImageDetailsEntity] = []) {
        self.name = name
        self.breedImages = breedImages
    }
}

extension BreedEntity: Equatable {}
