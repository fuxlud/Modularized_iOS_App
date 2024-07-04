import Foundation

public protocol BreedDetailsRepositoryProtocol {
    func getBreedDetails() async throws -> [ImageDetailsEntity]
}
