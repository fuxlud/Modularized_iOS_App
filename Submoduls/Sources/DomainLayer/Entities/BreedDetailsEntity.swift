import Foundation

public class BreedDetailsEntity: Codable {
    public let url: URL
    public var isFavorite = false
    
    public init(url: URL, isFavorite: Bool = false) {
        self.url = url
        self.isFavorite = isFavorite
    }
}

extension BreedDetailsEntity: Equatable {
    public static func == (lhs: BreedDetailsEntity, rhs: BreedDetailsEntity) -> Bool {
        return lhs.url == rhs.url
    }
}
