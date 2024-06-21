import Foundation
import Domain
import Networking

// Extension to map from RecipeDTO to Recipe entity
extension RecipeDTO {
    func toRecipeEntity() -> RecipeEntity {
        return RecipeEntity(
            id: self.id,
            title: self.title,
            image: self.image,
            imageType: self.imageType,
            servings: self.servings,
            readyInMinutes: self.readyInMinutes,
            sourceUrl: self.sourceUrl
        )
    }
}

// Extension to map from Recipe to RecipeDTO
extension RecipeEntity {
    func toRecipeDTO() -> RecipeDTO {
        return RecipeDTO(
            id: self.id,
            title: self.title,
            image: self.image,
            imageType: self.imageType,
            servings: self.servings,
            readyInMinutes: self.readyInMinutes,
            sourceUrl: self.sourceUrl
        )
    }
}
