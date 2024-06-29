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
    
    struct State: Equatable {
        var recipes: [RecipeEntity] = []
        var error: Toast?
        var isLoading = false
    }

    enum Action {
        case onAppear
    }

    @Published var state: State  = .init()

    func dispatch(_ action: Action) async {
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
//        state.recipeViewModels = recipes.map { RecipeViewModel(recipe: $0) }
        state.recipes = recipes
    }

    @MainActor
    private func handleError(_ error: Error) {
        guard let error = error as? RecipyErrorEntity else {
            state.error = .init(style: .error, message: error.localizedDescription)
            return
        }
        state.error = .init(style: .error, message: error.description)
    }
    
  //not sure i need
//    @Published private(set) var recipeViewModels = [RecipeViewModel]()
//
//
//    func loadRecipes() async throws {
//        do {
//            let recipes = try await randomRecipesUseCase.getRandomRecipes()
//            self.recipeViewModels = recipes.map { RecipeViewModel(recipe: $0) }
//        } catch {
//            print(error)
//        }
//    }
}
