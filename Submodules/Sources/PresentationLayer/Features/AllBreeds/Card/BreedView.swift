import SwiftUI
import DomainLayer
import PresentationLayer_DesignSystem

public struct BreedView: View {
    var viewModel: BreedViewModel
    public init(viewModel: BreedViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        Text(viewModel.title)
            .font(.headline)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .background(
                ColorfulMeshGradient()
            )
            .cornerRadius(8)
            .foregroundColor(.black)
            .shadow(color: Color(.black).opacity(0.2), radius: 5, x: 0, y: 5)
    }
}

struct BreedView_Preview: PreviewProvider {
    static var previews: some View {
        let breedMock = BreedEntity.mock.first
        let viewModel = BreedViewModel(breed: breedMock!)
        
        return BreedView(viewModel: viewModel)
            .previewLayout(.sizeThatFits)
    }
}
