import Foundation

public struct AnalyzedInstruction: Codable {
    public let name: String
    public let steps: [Step]
}

