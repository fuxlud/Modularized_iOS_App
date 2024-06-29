import Foundation
import Domain

public class RecipeViewModel: ObservableObject, Identifiable, Equatable {
    private let recipe: RecipeEntity
    public let id = UUID() 
    
    public init(recipe: RecipeEntity) {
        self.recipe = recipe
    }

    public var title: String {
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
    
    public static func == (lhs: RecipeViewModel, rhs: RecipeViewModel) -> Bool {
      return lhs.id == rhs.id && lhs.recipe == rhs.recipe
    }
}
