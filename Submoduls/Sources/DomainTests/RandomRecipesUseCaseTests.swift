import Testing
import Domain
import DomainMock

struct RandomRecipesUseCaseTests {
    
    @Test func whenFetchRecipiesSuccess_shouldReturnRecipiesList() async {
        let sut = RandomRecipesUseCaseMock(recipes: RecipeEntity.mock)
        
        do {
            let recipies = try await sut.getRandomRecipes()
            
            #expect(recipies.count == 20)
            
            if let recipy = recipies.first {
                #expect(recipy.title == "Traditional spare ribs baked")
            }
        } catch {}
    }
    
    @Test func whenFetchRecipiesFailure_shouldReturnRecipiesError() async {
        let sut = RandomRecipesUseCaseMock(error: RecipeErrorEntity.general)
        
        do {
            let _ = try await sut.getRandomRecipes()
        } catch let error {
            guard let concreteError = error as? RecipeErrorEntity else { return }
            #expect(concreteError == RecipeErrorEntity.general)
        }
    }
}
