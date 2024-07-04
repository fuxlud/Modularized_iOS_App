import SwiftUI
import Domain
import DesignSystem

public struct BreedView: View {
    var viewModel: BreedViewModel
    
    public init(viewModel: BreedViewModel) {
        self.viewModel = viewModel
    }
    
    private let imageWidth = 110.0
    private let cellHeight = 130.0
    
    public var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.title)
                .font(.headline)
                .lineLimit(2)
        }
        .padding([.leading, .trailing, .bottom])
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: Color(.black).opacity(0.2), radius: 5, x: 0, y: 5)
    }
}
