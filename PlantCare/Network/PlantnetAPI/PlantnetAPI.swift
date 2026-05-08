import AtlasNetwork
import Foundation
import UIKit

protocol PlantnetAPIProtocol: Sendable {
    func setKey(key: String) -> Self
    func identify(image: UIImage) async -> Result<PlantnetIdentifyResponse, AtlasNetworkError>
}

struct PlantnetAPI: PlantnetAPIProtocol {
    var API_URL = "https://my-api.plantnet.org"
    var key: String = ""
    var endpoint: PlantnetEndpoint?
    
    func setKey(key: String) -> PlantnetAPI {
        var newSelf = self
        newSelf.key = key
        
        return newSelf
    }
    
    func buildURL(endpoint: PlantnetEndpoint, query: [URLQueryItem], link: String?) throws -> URL {
        guard var components = URLComponents(string: API_URL) else {
            throw AtlasNetworkError.malformed
        }
        
        var newQuery = query
        newQuery.append(.init(name: "api-key", value: key))
        
        if let link {
            if let items = URLComponents(string: link)?.queryItems {
                newQuery.append(contentsOf: items)
            }
        }
        
        components.path = "/v2/"+endpoint.endpoint
        
        components.queryItems = newQuery
        
        guard let url = components.url else {
            throw AtlasNetworkError.malformed
        }
        
        return url
    }
    
    func setEndpoint(endpoint: PlantnetEndpoint) -> PlantnetAPI {
        var newSelf = self
        newSelf.endpoint = endpoint
        
        return newSelf
    }
    
    func build(query: [URLQueryItem] = [], link: String?, body: Data?) throws -> AtlasURLRequest {
        guard let endpoint else {
            throw AtlasNetworkError.malformed
        }
        
        let url = try buildURL(endpoint: endpoint, query: query, link: link)
        
        var urlRequest = URLRequest(
            url: url
        )
        
        urlRequest.httpMethod = endpoint.httpMethod.rawValue
        urlRequest.setValue(endpoint.contentType, forHTTPHeaderField: "Content-Type")
        
        if let body {
            urlRequest.httpBody = body
        }
        
        return .init(request: urlRequest)
    }
    
    func identify(image: UIImage) async -> Result<PlantnetIdentifyResponse, AtlasNetworkError> {
        do {
            let boundary = UUID().uuidString
            guard let imageData = image.jpegData(compressionQuality: 0.8) else {
                return .failure(.malformed)
            }
            
            var body = Data()
            
            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"images\"; filename=\"image.jpg\"\r\n")
            body.append("Content-Type: image/jpeg\r\n\r\n")
            body.append(imageData)
            body.append("\r\n")
            
            body.append("--\(boundary)--\r\n")
            
            return try await self
                .setEndpoint(endpoint: .identify(boundary))
                .build(link: nil, body: body)
                .response()
                .decode()
        } catch {
            return .failure(.generic(reason: error.localizedDescription))
        }
    }
}
