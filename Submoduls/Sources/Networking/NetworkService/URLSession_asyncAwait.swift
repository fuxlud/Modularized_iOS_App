import Foundation

// www.swiftbysundell.com/articles/making-async-system-apis-backward-compatible/
@available(iOS, deprecated: 15.0, message: "Use the built-in API instead")
extension URLSession {
    func data(fromURLRequest urlRequest: URLRequest) async throws -> (Data, URLResponse) {
        try await withCheckedThrowingContinuation { continuation in
            let task = self.dataTask(with: urlRequest) { data, response, error in
                guard let data = data, let response = response else {
                    let error = error ?? URLError(.badServerResponse)
                    return continuation.resume(throwing: error)
                }

                continuation.resume(returning: (data, response))
            }

            task.resume()
        }
    }
}
