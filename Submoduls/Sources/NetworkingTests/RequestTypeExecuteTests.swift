import Testing
import Foundation
@testable import Networking

struct RequestTypeExecuteTests {
    
    @Test func executeFailure() async throws {
        let request = MockGetTestingStubDetails()
        let mockRouter = MockRouter(jsonStub: nil)

        do {
          _ = try await request.execute(on: mockRouter)
        } catch {
            #expect(error as! RequestError == RequestError.mockRouterFailure)
        }
    }

    @Test func executeParsesJSON() async {
        let stubResponse = "{\"result\": [{\"stubID\": \"a\",\"name\": \"b\", \"image\": \"fake.image.url.com\"}]}"
        
      let mockRouter = MockRouter(jsonStub: stubResponse)

      do {
        let request = Request(path: nil)
        let data = (try await mockRouter.request(request))!

        let testingStubsInDic = try JSONDecoder().decode(MockGetTestingStubDetails.ResponseType.self, from: data)
        let testingStubs = testingStubsInDic["result"]
        #expect(testingStubs != nil)
        let testingStub = testingStubs!.first
        #expect(testingStub!.stubID == "a")
        #expect(testingStub!.name == "b")
        #expect(testingStub!.image == "fake.image.url.com")
      } catch {}
    }
}
