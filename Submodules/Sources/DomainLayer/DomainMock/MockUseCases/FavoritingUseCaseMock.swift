import Combine

public struct FavoritingUseCaseMock: FavoritingUseCaseProtocol {
    var breedDetailsEntity: BreedDetailsEntity
    
    public init(breedDetailsEntity: BreedDetailsEntity) {
        self.breedDetailsEntity = breedDetailsEntity
    }
    
    public func toggleLiking(breedDetailsEntity: BreedDetailsEntity) {
        ()
    }
}
