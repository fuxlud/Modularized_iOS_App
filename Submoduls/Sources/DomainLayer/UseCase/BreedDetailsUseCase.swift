import Foundation

public protocol BreedDetailsUseCaseProtocol {
  func getBreedDetails(breedName: String) async throws -> [BreedDetailsEntity]
}

public struct BreedDetailsUseCase: BreedDetailsUseCaseProtocol {
  private let repository: BreedDetailsRepositoryProtocol

  public init(repository: BreedDetailsRepositoryProtocol) {
    self.repository = repository
  }

  public func getBreedDetails(breedName: String) async throws -> [BreedDetailsEntity] {
    var breedDetails = try await repository.getRemoteBreedDetails(breedName: breedName)
    let favorites = await repository.fetchFavorites() // TODO: Parallelize

    for i in 0..<breedDetails.count {
      if favorites.contains(breedDetails[i]) {
        breedDetails[i].isFavorite = true
      }
    }
    return breedDetails
  }
}
