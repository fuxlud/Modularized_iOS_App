import SwiftUI

public struct CacheAsyncImage<Content>: View where Content: View {
    
    private let url: URL
    private let scale: CGFloat
    private let transaction: Transaction
    private let content: (AsyncImagePhase) -> Content
    
    public init(
        url: URL,
        scale: CGFloat = 1.0,
        transaction: Transaction = Transaction(),
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    ) {
        self.url = url
        self.scale = scale
        self.transaction = transaction
        self.content = content
    }
    
    public var body: some View {
        
        if let cached = ImageCache[url] {
            content(.success(cached))
        } else {
            AsyncImage(
                url: url,
                scale: scale,
                transaction: transaction
            ) { phase in
                cacheAndRender(phase: phase)
            }
        }
    }
    
    func cacheAndRender(phase: AsyncImagePhase) -> some View {
        if case .success(let image) = phase {
            ImageCache[url] = image
        }
        
        return content(phase)
    }
}

struct CacheAsyncImage_Previews: PreviewProvider {
    
    
    static var previews: some View {
        let imageWidth = 110.0
        let cellHeight = 130.0
        
        return Group {
            
            CacheAsyncImage(
                url: URL(string: "https://img.spoonacular.com/recipes/639866-556x370.jpg")!
            ) { phase in
                switch phase {
                case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                case .failure(let error):
                    ErrorView(error: error)
                    Circle()
                case .empty:
                    HStack {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .red))
                        Spacer()
                    }
                @unknown default:
                    Image(systemName: "questionmark")
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: cellHeight)
            .listRowSeparator(.hidden)
        }
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: Color(.black).opacity(0.2), radius: 5, x: 0, y: 5)
    }
}


fileprivate class ImageCache {
    static private var cache: [URL: Image] = [:]
    
    static subscript(url: URL) -> Image? {
        get {
            ImageCache.cache[url]
        }
        set {
            ImageCache.cache[url] = newValue
        }
    }
}

