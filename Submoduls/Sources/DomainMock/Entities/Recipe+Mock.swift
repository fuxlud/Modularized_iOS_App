import Domain
import Foundation

public extension RecipeEntity {
    
    static let mock = [
        RecipeEntity(id: 1,
                     title: "Traditional spare ribs baked",
                     image: "https://example.com/ribs.jpg",
                     imageType: "jpg",
                     servings: 4,
                     readyInMinutes: 120,
                     sourceUrl: "https://example.com/recipe1"),
        
        RecipeEntity(id: 2,
                     title: "Lamb chops with fruity couscous and mint",
                     image: "https://example.com/lamb.jpg",
                     imageType: "jpg",
                     servings: 2,
                     readyInMinutes: 45,
                     sourceUrl: "https://example.com/recipe2"),
        
        RecipeEntity(id: 3,
                     title: "Spice roasted chicken with flavored rice",
                     image: "https://example.com/chicken.jpg",
                     imageType: "jpg",
                     servings: 3,
                     readyInMinutes: 60,
                     sourceUrl: "https://example.com/recipe3"),
        
        RecipeEntity(id: 4,
                     title: "Chinese style Egg fried rice with sliced pork",
                     image: "https://example.com/fried_rice.jpg",
                     imageType: "jpg",
                     servings: 2,
                     readyInMinutes: 30,
                     sourceUrl: "https://example.com/recipe4"),
        RecipeEntity(id: 5,
                     title: "Traditional spare ribs baked",
                     image: "https://example.com/ribs.jpg",
                     imageType: "jpg",
                     servings: 4,
                     readyInMinutes: 120,
                     sourceUrl: "https://example.com/recipe1"),
        
        RecipeEntity(id: 6,
                     title: "Lamb chops with fruity couscous and mint",
                     image: "https://example.com/lamb.jpg",
                     imageType: "jpg",
                     servings: 2,
                     readyInMinutes: 45,
                     sourceUrl: "https://example.com/recipe2"),
        
        RecipeEntity(id: 7,
                     title: "Spice roasted chicken with flavored rice",
                     image: "https://example.com/chicken.jpg",
                     imageType: "jpg",
                     servings: 3,
                     readyInMinutes: 60,
                     sourceUrl: "https://example.com/recipe3"),
        
        RecipeEntity(id: 8,
                     title: "Chinese style Egg fried rice with sliced pork",
                     image: "https://example.com/fried_rice.jpg",
                     imageType: "jpg",
                     servings: 2,
                     readyInMinutes: 30,
                     sourceUrl: "https://example.com/recipe4")
    ]
}
