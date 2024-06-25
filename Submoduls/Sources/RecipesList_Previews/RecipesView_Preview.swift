import SwiftUI
import DesignSystem
import RecipesList
//import Domain
import DomainMock

struct RecipesView_Preview: PreviewProvider {
    static var previews: some View {
        let repositoryMock = RandomRecipesRepositoryMock()
        let viewModel = RecipesViewModel(repository: repositoryMock)
        RecipesView(viewModel: viewModel)
    }
}
