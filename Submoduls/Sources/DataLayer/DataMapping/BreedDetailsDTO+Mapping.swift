import Foundation
import DomainLayer
import Networking

extension BreedDetailsDTO {
    func toBreedDetailsEntity() -> BreedDetailsEntity {
        return BreedDetailsEntity(
            url: self.url,
            isFavorite: false)
    }
}
