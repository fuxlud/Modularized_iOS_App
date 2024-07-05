import Testing
@testable import DomainLayer


struct WeightConverterTests {
    
    let converter = WeightConverter()
    
    @Test func convertGramToOunce() {
        let result = converter.convert(100, from: .gram, to: .ounce)
        #expect(abs(result - 3.527396) < 0.0001)
    }
    
    @Test func convertGramToPound() {
        let result = converter.convert(100, from: .gram, to: .pound)
        #expect(abs(result - 0.220462) < 0.0001)
    }
    
    @Test func convertOunceToGram() {
        let result = converter.convert(3.527396, from: .ounce, to: .gram)
        #expect(abs(result - 100) < 0.0001)
    }
    
    @Test func convertOunceToPound() {
        let result = converter.convert(16, from: .ounce, to: .pound)
        #expect(abs(result - 1) < 0.0001)
    }
    
    @Test func convertPoundToGram() {
        let result = converter.convert(1, from: .pound, to: .gram)
        #expect(abs(result - 453.592) < 0.001)
    }
    
    @Test(.disabled("Due to a known crash - testing out disabled functionality"),
          .bug("https://developer.apple.com/videos/play/wwdc2024/10179/", "This is an example comment, replace with actualt bug discription"))
    func convertPoundToOunce() {
        let result = converter.convert(1, from: .pound, to: .ounce)
        #expect(abs(result - 16) < 0.0001)
    }
}
