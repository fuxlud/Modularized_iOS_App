import Foundation

public class ImageDetailsEntity: Codable {
    public let url: URL
    public var isFavorite = false
    public var breedName = ""
    
    public init(url: URL, isFavorite: Bool = false) {
        self.url = url
        self.isFavorite = isFavorite
    }
}

extension ImageDetailsEntity: Equatable {
    public static func == (lhs: ImageDetailsEntity, rhs: ImageDetailsEntity) -> Bool {
        return lhs.url == rhs.url
    }
}
