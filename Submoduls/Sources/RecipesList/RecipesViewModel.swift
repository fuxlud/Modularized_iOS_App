import Foundation
import SwiftUI
import Domain
import DesignSystem

@MainActor
public class RecipesViewModel: ObservableObject {
    
    @Published public var state: ViewState<[RecipeViewModel]> = .idle(data: [])
    
    private let randomRecipesUseCase: RandomRecipesUseCaseProtocol
    
    public init(randomRecipesUseCase: RandomRecipesUseCaseProtocol) {
        self.randomRecipesUseCase = randomRecipesUseCase
    }
    
    public enum Action {
        case onAppear
    }
    
    public func dispatch(_ action: Action) async {
        switch action {
        case .onAppear:
            await fetchRecipes()
        }
    }
    
    func fetchRecipes() async {
        do {
            let recipes = try await fetchRecipesRemote()
            fillRecipes(recipes)
        } catch let error {
            handleError(error)
        }
    }
    
    func fetchRecipesRemote() async throws -> [RecipeEntity] {
        return try await randomRecipesUseCase.getRandomRecipes()
    }
    
    @MainActor
    private func handleLoading(_ isLoading: Bool) {
        if isLoading {
            state = .loading
        } else {
            if let recipeViewModels = state.data {
                state = .idle(data: recipeViewModels)
            }
        }
    }
    
    @MainActor
    private func fillRecipes(_ recipes: [RecipeEntity]) {
        let recipeViewModels = recipes.map { RecipeViewModel(recipe: $0) }
        state = .idle(data: recipeViewModels)
    }
    
    @MainActor
    private func handleError(_ error: Error) {
        guard let error = error as? RecipeErrorEntity else {
            state = .error(message: error.localizedDescription)
            return
        }
        state = .error(message: error.description)
    }
}
