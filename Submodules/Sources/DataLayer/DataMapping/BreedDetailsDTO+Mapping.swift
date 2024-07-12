import Foundation
import DomainLayer

extension BreedDetailsDTO {
    func toBreedDetailsEntity() -> BreedDetailsEntity {
        return BreedDetailsEntity(
            url: self.url,
            isFavorite: self.isFavorite)
    }
}

extension BreedDetailsEntity {
    public func toBreedDetailsDTO() -> BreedDetailsDTO {
        return BreedDetailsDTO(
            url: self.url,
            isFavorite: self.isFavorite)
    }
}
