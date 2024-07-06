import SwiftUI

public struct MeshBackground: View {
    
    public init() {}
    
    public var body: some View {
        Group {
            if #available(iOS 18.0, *) {
                MeshGradient(width: 2, height: 2, points: [
                    [0, 0], [1, 0], [0, 1], [1, 1]
                ], colors: getRandomColors())
            } else {
                LinearGradient(gradient: Gradient(colors: getRandomColors()), startPoint: .topLeading, endPoint: .bottomTrailing)
            }
        }
    }
    
    func getRandomColors() -> [Color] {
      var randomColors: [Color] = []
        let colors = ThemePallet.colors
      if colors.count >= 4 {
        randomColors = Array(colors.shuffled().prefix(4))
      }
      return randomColors
    }
}
