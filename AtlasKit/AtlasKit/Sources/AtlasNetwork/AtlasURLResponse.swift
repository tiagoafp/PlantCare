import Foundation

public struct AtlasURLResponse {
    var jsonDecoder: JSONDecoder
    var result: Result<(Data, URLResponse), AtlasNetworkError>
    
    init(result: Result<(Data, URLResponse), AtlasNetworkError>) {
        self.result = result
        jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    public func decode<Data: Codable>() -> Result<Data, AtlasNetworkError> {
        switch result {
        case .success(let responseData):
            let data = responseData.0
            
            #if DEBUG
            print(String(data: data, encoding: .utf8)!)
            #endif
            
            do {
                return .success(try jsonDecoder.decode(Data.self, from: data))
            } catch {
                if let error = error as? DecodingError {
                    return .failure(.decode(error))
                }
                
                return .failure(.generic(reason: error.localizedDescription))
            }
        case .failure(let failure):
            return .failure(failure)
        }
    }
}


