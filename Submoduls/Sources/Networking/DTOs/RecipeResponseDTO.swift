import Foundation

public struct RecipeResponseDTO: Decodable {
    public let recipes: [RecipeDTO]

    public init(recipes: [RecipeDTO]) {
        self.recipes = recipes
    }
}
