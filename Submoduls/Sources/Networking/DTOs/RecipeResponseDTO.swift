import Foundation

public struct RecipeResponseDTO: Codable {
    public let recipes: [RecipeDTO]

    public init(recipes: [RecipeDTO]) {
        self.recipes = recipes
    }
}
