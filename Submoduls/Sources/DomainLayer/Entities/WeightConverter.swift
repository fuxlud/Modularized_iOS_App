import Foundation

public enum WeightUnit {
  case gram, ounce, pound
}

public struct WeightConverter {
  public func convert(_ value: Double, from fromUnit: WeightUnit, to toUnit: WeightUnit) -> Double {
    switch (fromUnit, toUnit) {
    case (.gram, .ounce):
      return value * 0.03527396
    case (.gram, .pound):
      return value * 0.00220462
    case (.ounce, .gram):
      return value / 0.03527396
    case (.ounce, .pound):
      return value * 0.0625
    case (.pound, .gram):
      return value / 0.00220462
    case (.pound, .ounce):
      return value / 0.0625
    default:
      return value
    }
  }
}
