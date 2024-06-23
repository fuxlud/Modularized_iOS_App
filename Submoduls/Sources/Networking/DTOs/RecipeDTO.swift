import Foundation

public struct RecipeDTO: Decodable {
    public let id: Int
    public let title: String
    public let image: String
    public let imageType: String
    public let servings: Int
    public let readyInMinutes: Int
    public let sourceUrl: String

    public init(id: Int, title: String, image: String, imageType: String, servings: Int, readyInMinutes: Int, sourceUrl: String) {
        self.id = id
        self.title = title
        self.image = image
        self.imageType = imageType
        self.servings = servings
        self.readyInMinutes = readyInMinutes
        self.sourceUrl = sourceUrl
    }
}

