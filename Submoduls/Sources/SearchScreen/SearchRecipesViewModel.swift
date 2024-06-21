import Foundation
import SwiftUI
import Domain
import DomainMock

@MainActor
public class SearchRecipesViewModel: ObservableObject {
    @Published private(set) var recipes = [RecipeEntity]()
    private let repository: RandomRecipesRepositoryMock
    
    public init(repository: RandomRecipesRepositoryMock) {
        self.repository = repository
    }

    func loadRecipes() async throws {
        do {
            let recipes = try await repository.getRandomRecipes()
            self.recipes = recipes
        } catch {
            print(error)
        }
    }
}
