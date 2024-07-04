public struct BreedsUseCaseMock: BreedsUseCaseProtocol {
    
    let breeds: [BreedEntity]?
    let error: Error?
    
    public func getAllBreeds() async throws -> [BreedEntity] {
        if let error {
            throw error
        }
        return breeds ?? []
    }
    
    public init(breeds: [BreedEntity]? = nil, error: Error? = nil) {
        self.breeds = breeds
        self.error = error
    }
}
