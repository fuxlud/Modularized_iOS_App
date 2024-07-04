import SwiftUI
import DesignSystem
import Domain

struct BreedView_Preview: PreviewProvider {
    static var previews: some View {
        let breedMock = BreedEntity.mock.first
        let viewModel = BreedViewModel(breed: breedMock!)
        
        return BreedView(viewModel: viewModel)
            .previewLayout(.sizeThatFits)
    }
}
