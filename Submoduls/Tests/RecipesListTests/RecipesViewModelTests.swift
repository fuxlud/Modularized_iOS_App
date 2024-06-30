import Testing
import Domain
import DomainMock
import RecipesList

struct RecipesViewModelTests {
    
    @Test func whenRecipesFetchedSuccesfully_shouldFillRecipesViewModelArray_andShowCorrectInfo() async {
        let sut = await makeSUT(randomRecipesUseCase: RandomRecipesUseCaseMock(recipes: RecipeEntity.mock))
        await sut.dispatch(.onAppear)
        
        await #expect(sut.state.data?.count == 20)
        await #expect(sut.state.error == nil)
        
        if let recipeViewModel = await sut.state.data?.first as? RecipeEntity {
            #expect(recipeViewModel.title == "Traditional spare ribs baked")
        }
    }
    
    @Test func whenAstronomiesFetchError_shouldPresentError() async {
        let sut = await makeSUT(randomRecipesUseCase: RandomRecipesUseCaseMock(error: RecipeErrorEntity.general))
        
        await sut.dispatch(.onAppear)
        
        await #expect(sut.state.error != nil)
        
        if let error = await sut.state.error {
            #expect(error == "Oops, something went wrong")
        }
    }
    
    
    // MARK: - Test helpers
    @MainActor
    func makeSUT(randomRecipesUseCase: some RandomRecipesUseCaseProtocol) -> RecipesViewModel {
        let sut = RecipesViewModel(randomRecipesUseCase: randomRecipesUseCase)
        return sut
    }
}
