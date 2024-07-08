import Testing
import DomainLayer
import PresentationLayer_Features_AllBreeds

struct BreedsViewModelTests {
    
    @Test func whenBreedsFetchedSuccesfully_shouldFillBreedsViewModelArray_andShowCorrectInfo() async {
        let sut = await makeSUT(breedsUseCase: BreedsUseCaseMock(breeds: BreedEntity.mock))
        await sut.dispatch(.executeOnceOnAppear)
        
        #expect(sut.state.data?.count == 10)
        #expect(sut.state.error == nil)
        
        if let breedViewModel = sut.state.data?.first as? BreedEntity {
            #expect(breedViewModel.name == "Golden Retriever")
        }
    }
    
    @Test func whenAstronomiesFetchError_shouldPresentError() async {
        let sut = await makeSUT(breedsUseCase: BreedsUseCaseMock(error: ErrorEntity.general))
        
        await sut.dispatch(.executeOnceOnAppear)
        
        #expect(sut.state.error != nil)
        
        if let error = sut.state.error {
            #expect(error == "Oops, something went wrong")
        }
    }
    
    @MainActor
    func makeSUT(breedsUseCase: some BreedsUseCaseProtocol) -> BreedsViewModel {
        let sut = BreedsViewModel(breedsUseCase: breedsUseCase)
        return sut
    }
}
