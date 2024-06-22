import SwiftUI

enum LocalError: Error {
    case test
}

public struct ErrorView: View {
    let error: Error

    public var body: some View {
        return Text("❌ **Error**").font(.system(size: 30))
    }
    
    public init(error: Error) {
        self.error = error
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: LocalError.test)
    }
}
