import SwiftUI

public struct FavoriteButton: View {
    
    var isOn: Bool
    var action: () -> Void
    private let padding: CGFloat = 3

    public init(isOn: Bool, action: @escaping () -> Void) {
        self.isOn = isOn
        self.action = action
    }
    
    public var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    action()
                }) {
                    Group {
                        if isOn {
                            Image(systemName: "heart.fill")
                        } else {
                            Image(systemName: "heart")
                        }
                    }
                    .font(.system(size: 28, weight: .medium))
                    .foregroundColor(.white)
                }
            }
            .padding(padding)
        }
        .padding(padding)
    }
}
