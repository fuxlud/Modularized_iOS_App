import Foundation

public struct RecipeResponseEntity: Codable {
    public let recipes: [RecipeEntity]
    
    public init(recipes: [RecipeEntity]) {
        self.recipes = recipes
    }
}
