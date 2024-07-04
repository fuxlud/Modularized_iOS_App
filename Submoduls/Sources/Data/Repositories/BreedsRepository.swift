import Foundation
import Domain
import Networking

public struct BreedsRepository: BreedsRepositoryProtocol {
    
    private let service: WebService

    public init(service: WebService) {
        self.service = service
    }
    
    public func getAllBreeds() async throws -> [BreedEntity] {
        let dto: [BreedDTO] = try await service.getAllBreeds()
        return dto.map { $0.toBreedEntity() }
    }
}
