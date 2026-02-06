import Foundation
import DomainLayer
import InfrastructureLayer

public struct BreedsRepository: BreedsRepositoryProtocol, Sendable {
    
    private let service: WebService

    public init(service: WebService) {
        self.service = service
    }
    
    public func getAllBreeds() async throws -> [BreedEntity] {
        let dto: [BreedDTO] = try await service.getAllBreeds()
        return dto.map { $0.toBreedEntity() }
    }
}
