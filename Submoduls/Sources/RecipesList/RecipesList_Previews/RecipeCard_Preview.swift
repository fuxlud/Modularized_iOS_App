import SwiftUI
import DesignSystem
import RecipesList
import Domain

struct RecipeCard_Previews: PreviewProvider {
    static var previews: some View {
        let recipeMock = RecipeEntity.mock.first
        let viewModel = RecipeViewModel(recipe: recipeMock!)
        
        return RecipeCard(viewModel: viewModel)
            .previewLayout(.sizeThatFits)
    }
}
