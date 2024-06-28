import XCTest
@testable import Networking

// Sut is the execute function,
// which is shared between all requests (structs that conform to RequestTypeProtocol.
// This is why there is no sut definition in the beginning and a setup/makeSut functions.

class RequestTypeExecuteTests: XCTestCase {
    var stubResponse = "{\"result\": [ {\"stubID\": \"a\",\"name\": \"b\", \"image\": \"fake.image.url.com\"}]}"

    func testExecuteFailure() async {
        let request = MockGetTestingStubDetails()
        let mockRouter = MockRouter(jsonStub: nil)

        do {
            _ = try await request.execute(on: mockRouter)
            XCTFail("testingStubs should be nil")
        } catch {
            let error = error as NSError
            XCTAssert(error.code == 101)
            XCTAssert(error.domain == "mock router failure")
        }
    }

    func testExecuteParsesJSON() async {
        let mockRouter = MockRouter(jsonStub: stubResponse)

        do {
            let request = Request(path: nil)
            let data = (try await mockRouter.request(request))!

            let testingStubsInDic = try JSONDecoder().decode(MockGetTestingStubDetails.ResponseType.self, from: data)
            let testingStubs = testingStubsInDic["result"]
            XCTAssertNotNil(testingStubs)
            let testingStub = testingStubs!.first
            XCTAssertEqual(testingStub!.stubID, "a")
            XCTAssertEqual(testingStub!.name, "b")
            XCTAssertEqual(testingStub!.image, "fake.image.url.com")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
