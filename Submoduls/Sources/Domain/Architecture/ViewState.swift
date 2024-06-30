import Foundation
import SwiftUI

public enum ViewState<T>: Equatable where T: Equatable {
    case idle(data: T)
    case loading
    case error(message: String)
    
    public static func ==(lhs: ViewState<T>, rhs: ViewState<T>) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case (.error(let lhsMessage), .error(let rhsMessage)):
            return lhsMessage == rhsMessage
        case (.idle(let lhsData), .idle(let rhsData)):
            return lhsData == rhsData
        default:
            return false
        }
    }
    
    public var data: T? {
        switch self {
        case .idle(let data):
            return data
        default:
            return nil
        }
    }
    
    public var isLoading: Bool {
        switch self {
        case .loading:
            return true
        default:
            return false
        }
    }
    
    public var error: String? {
        switch self {
        case .error(let message):
            return message
        default:
            return nil
        }
    }
}
