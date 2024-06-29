import SwiftUI
import DesignSystem
import RecipesList
import DomainMock
import Domain

struct RecipesView_Preview: PreviewProvider {
    static var previews: some View {

        let useCase = RandomRecipesUseCaseMock(recipes: RecipeEntity.mock)
        let viewModel = RecipesViewModel(randomRecipesUseCase: useCase)

        RecipesView(viewModel: viewModel)
    }
}
