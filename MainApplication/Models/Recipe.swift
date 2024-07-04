import Foundation

struct RecipeResponse: Codable {
    public let recipes: [Recipe]
}

public struct Recipe: Codable, Identifiable {
    public let id: Int
    public let title: String
    public let image: String
    public let imageType: String
    public let servings: Int
    public let readyInMinutes: Int
    public let sourceUrl: String
    public let nutrition: [Nutrition]?
    public let analyzedInstructions: [AnalyzedInstruction]?
}

