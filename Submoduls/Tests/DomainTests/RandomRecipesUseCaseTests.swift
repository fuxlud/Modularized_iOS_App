import Testing
import Domain

struct BreedsUseCaseTests {
    
    @Test func whenFetchRecipiesSuccess_shouldReturnRecipiesList() async {
        let sut = BreedsUseCaseMock(breeds: BreedEntity.mock)
        
        do {
            let breeds = try await sut.getAllBreeds()
            
            #expect(breeds.count == 10)
            
            if let recipy = breeds.first {
                #expect(recipy.name == "Golden Retriever")
            }
        } catch {}
    }
    
    @Test func whenFetchRecipiesFailure_shouldReturnRecipiesError() async {
        let sut = BreedsUseCaseMock(error: ErrorEntity.general)
        
        do {
            let _ = try await sut.getAllBreeds()
        } catch let error {
            guard let concreteError = error as? ErrorEntity else { return }
            #expect(concreteError == ErrorEntity.general)
        }
    }
}
