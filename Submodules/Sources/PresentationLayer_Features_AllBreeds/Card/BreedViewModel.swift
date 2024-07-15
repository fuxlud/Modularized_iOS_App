import Foundation
import DomainLayer

@Observable 
public class BreedViewModel: Identifiable {
    private let breed: BreedEntity
    public let id = UUID()
    
    public init(breed: BreedEntity) {
        self.breed = breed
    }
    
    public var title: String {
        breed.name.capitalized(with: .current)
    }
}

extension BreedViewModel: Equatable {
    public static func == (lhs: BreedViewModel, rhs: BreedViewModel) -> Bool {
      return lhs.id == rhs.id
    }
}
