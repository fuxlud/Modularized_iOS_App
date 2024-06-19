//
//  LudushRecipesApp.swift
//  LudushRecipes
//
//  Created by Luda Fux on 15/06/2024.
//

import SwiftUI
import Domain
import SearchScreenFeature

@main
struct LudushRecipesApp: App {
    var body: some Scene {
        WindowGroup {
            let mockRecipesFetcher = MockRecipesFetcher()
            let repository = Repository(recipesFetcher: mockRecipesFetcher)
            let viewModel = SearchRecipesViewModel(repository: repository)
            SearchRecipesView(viewModel: viewModel)
        }
    }
}
