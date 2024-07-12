import Foundation
import DomainLayer

extension BreedDTO {
    func toBreedEntity() -> BreedEntity {
        return BreedEntity(name: self.name)
    }
}
