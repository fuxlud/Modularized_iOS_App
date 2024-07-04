import Foundation
import Domain
import Networking

extension BreedDTO {
    func toBreedEntity() -> BreedEntity {
        return BreedEntity(name: self.name)
    }
}

extension BreedEntity {
    func toBreedDTO() -> BreedDTO {
        return BreedDTO(name: self.name)
    }
}
