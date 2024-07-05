import Foundation
import DomainLayer
import Networking

public struct BreedDetailsRepository: BreedDetailsRepositoryProtocol {

    private let service: WebService

    public init(service: WebService) {
        self.service = service
    }
    
    public func getBreedDetails(breedName: String) async throws -> [BreedDetailsEntity] {
        let dto: [BreedDetailsDTO] = try await service.getBreedDetails(breedName: breedName)
        return dto.map { $0.toBreedDetailsEntity() }
    }
}
