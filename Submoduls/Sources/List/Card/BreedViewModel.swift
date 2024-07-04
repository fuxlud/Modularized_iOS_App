import Foundation
import Domain

@Observable public class BreedViewModel: ObservableObject, Identifiable {
    private let breed: BreedEntity
    public let id = UUID()
    
    public init(breed: BreedEntity) {
        self.breed = breed
    }
    
    public var title: String {
        breed.name.capitalized(with: .current)
    }
    
    var imageUrl: URL? {
        breed.breedImages.first?.url
    }
}

extension BreedViewModel: Equatable {
    public static func == (lhs: BreedViewModel, rhs: BreedViewModel) -> Bool {
      return lhs.id == rhs.id
    }
}
