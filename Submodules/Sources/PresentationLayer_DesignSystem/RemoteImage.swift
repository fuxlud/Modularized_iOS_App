import Combine
import SwiftUI

@Observable 
class RemoteImageLoader {
    var data: Data = Data()

    init(imageURL: URL) {
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async { self.data = data }
        }
        .resume()
    }
}

public struct URLImage: View {
    @State var remoteImageLoader: RemoteImageLoader

    public init(_ imageUrl: URL) {
        remoteImageLoader = RemoteImageLoader(imageURL: imageUrl)
    }

    public var body: some View {
        Image(uiImage: UIImage(data: remoteImageLoader.data) ?? UIImage())
            .resizable()
            .scaledToFill()
    }
}

