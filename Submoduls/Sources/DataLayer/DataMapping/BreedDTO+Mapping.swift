import Foundation
import DomainLayer
import Networking

extension BreedDTO {
    func toBreedEntity() -> BreedEntity {
        return BreedEntity(name: self.name)
    }
}
