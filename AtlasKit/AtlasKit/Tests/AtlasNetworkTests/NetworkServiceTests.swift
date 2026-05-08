import Foundation
import Testing
@testable import AtlasNetwork

private struct MockTransport: NetworkTransport {
    let handler: (URLRequest) async throws -> (Data, URLResponse)

    func send(_ request: URLRequest) async throws -> (Data, URLResponse) {
        try await handler(request)
    }
}

private struct UserDTO: Codable, Equatable {
    let id: Int
    let name: String
}

@Test func networkServiceDecodesResponsesAsync() async throws {
    let request = URLRequest(url: try #require(URL(string: "https://example.com/users/1")))
    let responseData = try JSONEncoder().encode(UserDTO(id: 1, name: "Atlas"))
    let response = try #require(
        HTTPURLResponse(
            url: try #require(request.url),
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
    )

    let service = NetworkService(
        transport: MockTransport { receivedRequest in
            #expect(receivedRequest.url == request.url)
            return (responseData, response)
        }
    )

    let user = try await service.decode(UserDTO.self, from: request)

    #expect(user == UserDTO(id: 1, name: "Atlas"))
}

@Test func networkServicePerformsGenericOperationsAsync() async throws {
    let request = URLRequest(url: try #require(URL(string: "https://example.com/health")))
    let response = try #require(
        HTTPURLResponse(
            url: try #require(request.url),
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
    )

    let service = NetworkService(
        transport: MockTransport { _ in
            (Data("ok".utf8), response)
        }
    )

    let operation = NetworkOperation<String>(request: request) { data, receivedResponse in
        #expect((receivedResponse as? HTTPURLResponse)?.statusCode == 200)
        return String(decoding: data, as: UTF8.self)
    }

    let value = try await service.perform(operation)

    #expect(value == "ok")
}

@Test func networkServiceThrowsForUnexpectedStatusCodes() async throws {
    let request = URLRequest(url: try #require(URL(string: "https://example.com/failure")))
    let failureBody = Data("nope".utf8)
    let response = try #require(
        HTTPURLResponse(
            url: try #require(request.url),
            statusCode: 500,
            httpVersion: nil,
            headerFields: nil
        )
    )

    let service = NetworkService(
        transport: MockTransport { _ in
            (failureBody, response)
        }
    )

    do {
        _ = try await service.data(for: request)
        Issue.record("Expected unsuccessful status code error.")
    } catch let error as NetworkServiceError {
        #expect(error == .unsuccessfulStatusCode(500, failureBody))
    }
}
