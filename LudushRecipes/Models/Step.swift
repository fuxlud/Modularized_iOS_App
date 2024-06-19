import Foundation

public struct Step: Codable {
    public let number: Int
    public let step: String
    public let ingredients: [Ingredient]
    public let equipment: [Equipment]
}
