import Foundation
import Domain
import Networking

extension BreedDTO {
    func toBreedEntity() -> BreedEntity {
        return BreedEntity(name: self.name)
    }
}
