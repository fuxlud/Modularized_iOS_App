import XCTest
import Domain
import DomainMock

final class UseCaseTest: XCTestCase {

    func testWhenFetchAstronomiesSuccess_shouldReturnAstronomiesList() async  {
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
}
