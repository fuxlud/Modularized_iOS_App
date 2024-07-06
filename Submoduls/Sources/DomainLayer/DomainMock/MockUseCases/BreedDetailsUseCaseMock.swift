public struct BreedDetailsUseCaseMock: BreedDetailsUseCaseProtocol {
    
    let breedDetails: [BreedDetailsEntity]?
    let error: Error?
    
    public init(breedDetails: [BreedDetailsEntity]? = nil, error: Error? = nil) {
        self.breedDetails = breedDetails
        self.error = error
    }

    public func getBreedDetails(breedName: String) async throws -> [BreedDetailsEntity] {
        if let error {
            throw error
        }
        return breedDetails ?? []
    }
}
