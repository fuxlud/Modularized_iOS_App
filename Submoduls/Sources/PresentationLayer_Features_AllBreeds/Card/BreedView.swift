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
        .background(ThemePallet.colors.randomElement())
        .cornerRadius(8)
        .foregroundColor(.black)
        .shadow(color: Color(.black).opacity(0.2), radius: 5, x: 0, y: 5)
  }
}
