import Foundation
import SwiftUI
import Domain
import DesignSystem

@MainActor
public class RecipesViewModel: ObservableObject {
    
    private let randomRecipesUseCase: RandomRecipesUseCaseProtocol
    
    public init(randomRecipesUseCase: RandomRecipesUseCaseProtocol) {
        self.randomRecipesUseCase = randomRecipesUseCase
    }
    
    public struct State: Equatable {
        public var recipeViewModels: [RecipeViewModel] = []
        public var error: Toast?
        public var isLoading = false
    }
    
    public enum Action {
        case onAppear
    }
    
    @Published public var state: State  = .init()
    
    public func dispatch(_ action: Action) async {
        switch action {
        case .onAppear:
            await fetchRecipies()
        }
    }
    
    func fetchRecipies() async {
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
        state.isLoading = isLoading
    }
    
    @MainActor
    private func fillRecipes(_ recipes: [RecipeEntity]) {
        state.recipeViewModels = recipes.map { RecipeViewModel(recipe: $0) }
    }
    
    @MainActor
    private func handleError(_ error: Error) {
        guard let error = error as? RecipeErrorEntity else {
            state.error = .init(style: .error, message: error.localizedDescription)
            return
        }
        state.error = .init(style: .error, message: error.description)
    }
}
