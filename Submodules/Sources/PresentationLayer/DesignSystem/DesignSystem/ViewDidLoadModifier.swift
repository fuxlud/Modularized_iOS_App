import SwiftUI

public struct ExecuteOnceOnAppearModifier: ViewModifier {
    @State private var hasAppeared = false
    let action: (() -> Void)?
    
    public func body(content: Content) -> some View {
        content
            .onAppear {
                if hasAppeared == false {
                    hasAppeared = true
                    action?()
                }
            }
    }
}

public extension View {
    func executeOnceOnAppear(perform action: (() -> Void)? = nil) -> some View {
        self.modifier(ExecuteOnceOnAppearModifier(action: action))
    }
}
