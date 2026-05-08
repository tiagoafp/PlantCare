import Foundation

public class AtlasURLRequest {
    public var request: URLRequest
    
    public init(request: URLRequest) {
        self.request = request
    }
    
    public func response() async -> AtlasURLResponse {
        do {
            let response = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response.1 as? HTTPURLResponse else {
                return .init(result: .failure(.malformed))
            }

            return .init(result: .success(response))
        } catch {
            return .init(
                result: .failure(
                    .generic(
                        reason: error.localizedDescription
                    )
                )
            )
        }
    }
}
