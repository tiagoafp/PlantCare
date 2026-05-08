import AtlasNetwork
import Foundation

protocol TrefleAPIProtocol: Sendable {
    func setKey(key: String) -> Self
    func getPlantsList(link: String?) async -> Result<TrefleListResponse, AtlasNetworkError>
    func searchPlantsList(search: String, link: String?) async -> Result<TrefleListResponse, AtlasNetworkError>
}

struct TrefleAPI: TrefleAPIProtocol {
    
    var API_URL = "https://trefle.io"
    var key: String = ""
    var endpoint: TrefleEndpoint?
    
    func setKey(key: String) -> TrefleAPI {
        var newSelf = self
        newSelf.key = key
        
        return newSelf
    }
    
    func buildURL(endpoint: TrefleEndpoint, query: [URLQueryItem], link: String?) throws -> URL {
        guard var components = URLComponents(string: API_URL) else {
            throw AtlasNetworkError.malformed
        }
        
        var newQuery = query
        newQuery.append(.init(name: "token", value: key))
        
        if let link {
            if let items = URLComponents(string: link)?.queryItems {
                newQuery.append(contentsOf: items)
            }
        }
        
        components.path = "/api/v1/"+endpoint.endpoint
        
        components.queryItems = newQuery
        
        guard let url = components.url else {
            throw AtlasNetworkError.malformed
        }
        
        return url
    }
    
    func setEndpoint(endpoint: TrefleEndpoint) -> TrefleAPI {
        var newSelf = self
        newSelf.endpoint = endpoint
        
        return newSelf
    }
    
    func build(query: [URLQueryItem] = [], link: String?) throws -> AtlasURLRequest {
        guard let endpoint else {
            throw AtlasNetworkError.malformed
        }
        
        var newQuery: [URLQueryItem] = [
            .init(name: "order[scientific_name]", value: "asc")
        ]
        
        newQuery.append(contentsOf: query)
        
        let url = try buildURL(endpoint: endpoint, query: newQuery, link: link)
        
        var urlRequest = URLRequest(
            url: url
        )
        
        urlRequest.httpMethod = endpoint.httpMethod.rawValue
        
        return .init(request: urlRequest)
    }
    
    func getPlantsList(link: String?) async -> Result<TrefleListResponse, AtlasNetworkError> {
        do {
            return try await self
                .setEndpoint(endpoint: .plants)
                .build(
                    query: [
                        .init(name: "filter_not[image_url]", value: "null")
                    ],
                    link: link
                )
                .response()
                .decode()
        } catch {
            return .failure(.generic(reason: error.localizedDescription))
        }
    }
    
    func searchPlantsList(search: String, link: String?) async -> Result<TrefleListResponse, AtlasNetworkError> {
        do {
            var query: [URLQueryItem] = []
            
            if !search.isEmpty {
                query.append(.init(name: "q", value: search))
                
            }
            
            return try await self
                .setEndpoint(endpoint: .search)
                .build(query: query, link: link)
                .response()
                .decode()
        } catch {
            return .failure(.generic(reason: error.localizedDescription))
        }
    }
}
