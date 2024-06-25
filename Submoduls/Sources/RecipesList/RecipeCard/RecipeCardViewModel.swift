import Foundation
import Domain

public class RecipeViewModel: ObservableObject, Identifiable {
    private let recipe: RecipeEntity
    public let id = UUID() 
    
    public init(recipe: RecipeEntity) {
        self.recipe = recipe
    }

    var title: String {
        recipe.title
    }

    var servings: String {
        "Servings: \(recipe.servings)"
    }

    var readyInMinutes: String {
        "Ready in \(recipe.readyInMinutes) min"
    }

    var imageUrl: URL? {
        URL(string: recipe.image)
    }
}
