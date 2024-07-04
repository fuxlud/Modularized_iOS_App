import Testing
import Domain

struct BreedsUseCaseTests {
    
    @Test func whenFetchBreedsSuccess_shouldReturnBreedsList() async {
        let sut = BreedsUseCaseMock(breeds: BreedEntity.mock)
        
        do {
            let breeds = try await sut.getAllBreeds()
            
            #expect(breeds.count == 10)
            
            if let breed = breeds.first {
                #expect(breed.name == "Golden Retriever")
            }
        } catch {}
    }
    
    @Test func whenFetchBreedsFailure_shouldReturnBreedsError() async {
        let sut = BreedsUseCaseMock(error: ErrorEntity.general)
        
        do {
            let _ = try await sut.getAllBreeds()
        } catch let error {
            guard let concreteError = error as? ErrorEntity else { return }
            #expect(concreteError == ErrorEntity.general)
        }
    }
}
