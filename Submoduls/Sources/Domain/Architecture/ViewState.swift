import Foundation
import SwiftUI

public enum ViewState<T> {
    case idle(data: T)
    case loading
    case error(message: String)
    
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
