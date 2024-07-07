import SwiftUI

public struct ColorfulMeshGradient: View {
    
    public init() {}
    
    public var body: some View {
        Group {
            MeshGradient(width: 2, 
                         height: 2,
                         points: [ [0, 0], [1, 0], [0, 1], [1, 1]],
                         colors: getRandomColors())
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

#Preview {
    ColorfulMeshGradient()
}
