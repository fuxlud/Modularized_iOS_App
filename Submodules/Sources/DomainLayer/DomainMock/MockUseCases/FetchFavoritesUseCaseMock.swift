@preconcurrency import Combine

public struct FetchFavoritesUseCaseMock: FetchFavoritesUseCaseProtocol, @unchecked Sendable {
  public var itemsPublisher: AnyPublisher<[BreedDetailsEntity], Never>
  
  let breedDetails: [BreedDetailsEntity]
  
  public init(breedDetails: [BreedDetailsEntity]) {
    self.breedDetails = breedDetails
    self.itemsPublisher = Just(breedDetails).eraseToAnyPublisher()
  }
  
  public func fetchFavorites() async -> [BreedDetailsEntity] {
    return breedDetails
  }
}
