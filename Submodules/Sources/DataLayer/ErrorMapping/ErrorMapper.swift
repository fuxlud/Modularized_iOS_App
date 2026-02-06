import Foundation
import DomainLayer
import InfrastructureLayer

public enum ErrorMapper {
    public static func toErrorEntity(_ error: Error) -> ErrorEntity {
        if let errorEntity = error as? ErrorEntity {
            return errorEntity
        }

        if let apiError = error as? APIError {
            switch apiError {
            case .notFound:
                return .general
            default:
                return .general
            }
        }

        if error is RequestError {
            return .general
        }

        return ErrorEntity.from(error)
    }
}
