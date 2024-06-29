import XCTest
import Domain

class WeightConverterTests: XCTestCase {

  var converter: WeightConverter!

  override func setUp() {
    super.setUp()
    converter = WeightConverter()
  }

  override func tearDown() {
    converter = nil
    super.tearDown()
  }

  func testGramToOunce() {
    let result = converter.convert(100, from: .gram, to: .ounce)
    XCTAssertEqual(result, 3.527396, accuracy: 0.0001)
  }

  func testGramToPound() {
    let result = converter.convert(100, from: .gram, to: .pound)
    XCTAssertEqual(result, 0.220462, accuracy: 0.0001)
  }

  func testOunceToGram() {
    let result = converter.convert(3.527396, from: .ounce, to: .gram)
    XCTAssertEqual(result, 100, accuracy: 0.0001)
  }

  func testOunceToPound() {
    let result = converter.convert(16, from: .ounce, to: .pound)
    XCTAssertEqual(result, 1, accuracy: 0.0001)
  }

  func testPoundToGram() {
    let result = converter.convert(1, from: .pound, to: .gram)
    XCTAssertEqual(result, 453.592, accuracy: 0.001)
  }

  func testPoundToOunce() {
    let result = converter.convert(1, from: .pound, to: .ounce)
    XCTAssertEqual(result, 16, accuracy: 0.0001)
  }
}
