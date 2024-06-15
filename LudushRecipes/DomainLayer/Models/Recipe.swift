import Foundation

struct RecipeResponse: Codable {
    let recipes: [Recipe]
}

struct Recipe: Codable {
    let id: Int
    let title: String
    let image: String
    let imageType: String
    let servings: Int
    let readyInMinutes: Int
    let sourceUrl: String
    let nutrition: [Nutrition]?
    let analyzedInstructions: [AnalyzedInstruction]?
}
