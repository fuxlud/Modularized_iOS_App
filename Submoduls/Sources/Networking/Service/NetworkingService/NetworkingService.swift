import Foundation
import Combine

public class NetworkingService {
    public init() {}
    
    public func send<T: Decodable>(_ request: URLRequest) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APIError.notFound
        }
        return try await requestDecoder(data: data)
    }
}

extension NetworkingService {
    func requestDecoder<T: Decodable> (data: Data) async throws -> T {
        let decoder = JSONDecoder()
        do {
            let decodedValue = try decoder.decode(T.self, from: data)
            return decodedValue
        }
        catch let error {
            throw APIError.decoding(error: error)
        }
    }
}
