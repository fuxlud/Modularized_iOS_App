import XCTest
import Domain
import DomainMock

final class UseCaseTest: XCTestCase {

    func testWhenFetchRecipiesSuccess_shouldReturnRecipiesList() async  {
        let sut = RandomRecipesUseCaseMock(recipes: RecipeEntity.mock)

        do {
            let recipies = try await sut.getRandomRecipes()

            XCTAssertEqual(recipies.count, 20)

            if let recipy = recipies.first {
                XCTAssertEqual(recipy.title, "Traditional spare ribs baked")
            } else {
                XCTFail("RecipeEntity array shouldn't be empty")
            }

        } catch {
            XCTFail("Fetching astronomies should return results")
        }
    }
    
    func testWhenFetchRecipiesFailure_shouldReturnRecipiesError() async  {
        let sut = RandomRecipesUseCaseMock(error: RecipyErrorEntity.general)

        do {
            let _ = try await sut.getRandomRecipes()
        } catch let error {
            guard let concreteError = error as? RecipyErrorEntity else {
                XCTFail("The error should be of RecipyErrorEntity type")
                return
            }
            XCTAssertEqual(concreteError, RecipyErrorEntity.general)
        }
    }
}
