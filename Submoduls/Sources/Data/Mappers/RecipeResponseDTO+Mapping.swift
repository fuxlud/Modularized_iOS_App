import Foundation
import Domain
import Networking

// Extension to map from RecipeResponseDTO to RecipeResponse entity
extension RecipeResponseDTO {
    func toRecipeResponseEntity() -> RecipeResponseEntity {
        return RecipeResponseEntity (
            recipes: self.recipes.map { $0.toRecipeEntity() }
        )
    }
}

// Extension to map from RecipeResponse to RecipeResponseDTO
extension RecipeResponseEntity {
    func toRecipeResponseDTO() -> RecipeResponseDTO {
        return RecipeResponseDTO(
            recipes: self.recipes.map { $0.toRecipeDTO() }
        )
    }
}
