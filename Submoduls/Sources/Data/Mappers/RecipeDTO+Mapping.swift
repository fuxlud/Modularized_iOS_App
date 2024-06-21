import Foundation
import Domain
import Networking

// Extension to map from RecipeDTO to Recipe entity
extension RecipeDTO {
    func toRecipeEntity() -> RecipeEntity {
        return RecipeEntity(
            id: self.id,
            title: self.title
        )
    }
}

// Extension to map from Recipe to RecipeDTO
extension RecipeEntity {
    func toRecipeDTO() -> RecipeDTO {
        return RecipeDTO(
            id: self.id,
            title: self.title
        )
    }
}
