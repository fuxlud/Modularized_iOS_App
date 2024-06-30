import SwiftUI

struct ToastModifier: ViewModifier {
    @Binding var message: String?
    @Binding var style: ToastStyle?
    @State private var workItem: DispatchWorkItem?

    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
                ZStack {
                    mainToastView()
                        .offset(y: 32)
                }.animation(.spring(), value: message)
            )
            .onChange(of: message) { value in
                showToast()
            }
    }

    @ViewBuilder func mainToastView() -> some View {
        if let message = message, let style = style {
            VStack {
                ToastView(
                    style: style,
                    message: message
                ) {
                    dismissToast()
                }
                Spacer()
            }
        }
    }

    private func showToast() {
        guard let _ = message else { return }

        UIImpactFeedbackGenerator(style: .light)
            .impactOccurred()
        
        workItem?.cancel()
        
        let task = DispatchWorkItem {
            dismissToast()
        }
        
        workItem = task
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: task) // Assuming default duration is 3 seconds
    }

    private func dismissToast() {
        withAnimation {
            message = nil
            style = nil
        }

        workItem?.cancel()
        workItem = nil
    }
}

public extension View {
    func toastView(message: Binding<String?>, style: Binding<ToastStyle?>) -> some View {
        self.modifier(ToastModifier(message: message, style: style))
    }
}
