import SwiftUI
import PresentationLayer_DesignSystem
import DomainLayer

struct BreedView_Preview: PreviewProvider {
    static var previews: some View {
        let breedMock = BreedEntity.mock.first
        let viewModel = BreedViewModel(breed: breedMock!)
        
        return BreedView(viewModel: viewModel)
            .previewLayout(.sizeThatFits)
    }
}
