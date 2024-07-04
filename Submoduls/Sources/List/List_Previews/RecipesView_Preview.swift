//import SwiftUI
//import DesignSystem
//import Domain
//
//struct RecipesViewWithData_Preview: PreviewProvider {
//    static var previews: some View {
//
//        let useCase = RandomRecipesUseCaseMock(recipes: RecipeEntity.mock)
//        let viewModel = RecipesViewModel(randomRecipesUseCase: useCase)
//
//        RecipesView(viewModel: viewModel)
//    }
//}
//
//struct RecipesViewWithError_Preview: PreviewProvider {
//    static var previews: some View {
//
//        let errorUseCase = RandomRecipesUseCaseMock(error: RecipeErrorEntity.general)
//        let viewModel = RecipesViewModel(randomRecipesUseCase: errorUseCase)
//
//        RecipesView(viewModel: viewModel)
//    }
//}
