import SwiftUI
import DomainLayer
import PresentationLayer_DesignSystem

public struct BreedView: View {
  var viewModel: BreedViewModel
  
  public init(viewModel: BreedViewModel) {
    self.viewModel = viewModel
  }
  
  func getRandomColors() -> [Color] {
    var randomColors: [Color] = []
      let colors = ThemePallet.colors
    if colors.count >= 4 {
      randomColors = Array(colors.shuffled().prefix(4))
    }
    return randomColors
  }
  
  public var body: some View {
      Text(viewModel.title)
        .font(.headline)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(
            Group {
                if #available(iOS 18.0, *) {
                    MeshGradient(width: 2, height: 2, points: [
                        [0, 0], [1, 0], [0, 1], [1, 1]
                    ], colors: getRandomColors())
                } else {
                    LinearGradient(gradient: Gradient(colors: getRandomColors()), startPoint: .topLeading, endPoint: .bottomTrailing)
                }
            }
        )
        .cornerRadius(8)
        .foregroundColor(.black)
        .shadow(color: Color(.black).opacity(0.2), radius: 5, x: 0, y: 5)
  }
}
