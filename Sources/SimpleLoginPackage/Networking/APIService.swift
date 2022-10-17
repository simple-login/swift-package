//
//  APIService.swift
//  Swift Package
//
//  Created by Nhon Proton on 17/10/2022.
//

import Foundation

public enum HTTPMethod: String {
    case delete = "DELETE"
    case get = "GET"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
}

public enum APIServiceError: Error, CustomStringConvertible {
    case badUrlString(String)
    case clientError(ErrorResponse)
    case notHttpResponse
    case unknown(statusCode: Int)

    public var description: String {
        switch self {
        case .badUrlString(let urlString):
            return "Bad URL string \(urlString)"
        case .clientError(let error):
            return error.message
        case .notHttpResponse:
            return "Not HTTPResponse"
        case .unknown(let statusCode):
            return "Unknown error with status code \(statusCode)"
        }
    }
}

public protocol APIServiceProtocol {
    var baseURL: URL { get }
    var session: URLSession { get }

    func execute<E: EndpointV2>(_ endpoint: E) async throws -> E.Response
}

public extension APIServiceProtocol {
    func execute<E: EndpointV2>(_ endpoint: E) async throws -> E.Response {
        let request = try endpoint.makeRequest(from: baseURL)
        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIServiceError.notHttpResponse
        }

        switch httpResponse.statusCode {
        case 200...299:
            return try JSONDecoder().decode(E.Response.self, from: data)
        case 400...499:
            if var error = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                error.statusCode = httpResponse.statusCode
                throw APIServiceError.clientError(error)
            }
        default:
            break
        }
        throw APIServiceError.unknown(statusCode: httpResponse.statusCode)
    }
}

public final class APIService: APIServiceProtocol {
    public let baseURL: URL
    public let session: URLSession

    public init(baseURL: URL, session: URLSession) {
        self.baseURL = baseURL
        self.session = session
    }
}
