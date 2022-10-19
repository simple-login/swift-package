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
    case failedToConstructURL(URLComponents)
    case notHttpResponse
    case unknown(statusCode: Int)

    public var description: String {
        switch self {
        case .badUrlString(let urlString):
            return "Bad URL string \(urlString)"
        case .clientError(let error):
            return error.message
        case .failedToConstructURL:
            return "Failed to construct URL"
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
    var printDebugInformation: Bool { get }

    func execute<E: Endpoint>(_ endpoint: E) async throws -> E.Response
}

public extension APIServiceProtocol {
    func execute<E: Endpoint>(_ endpoint: E) async throws -> E.Response {
        let request = try endpoint.makeRequest(from: baseURL)
        printDebugInformation(request: request)
        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIServiceError.notHttpResponse
        }

        printDebugInformation(data: data, request: request, response: httpResponse)

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

private extension APIServiceProtocol {
    func printDebugInformation(request: URLRequest) {
        guard printDebugInformation,
              let method = request.httpMethod,
              let urlString = request.url?.absoluteString else { return }
        print("==> \(method) \(urlString)")

        if let headers = request.allHTTPHeaderFields, !headers.isEmpty {
            print("HEADERS:")
            for header in headers {
                print("\(header.key): \(header.value)")
            }
        }

        if let data = request.httpBody,
           let bodyString = String(data: data, encoding: .utf8) {
            print("BODY:")
            print(bodyString)
        }

        print("\n")
    }

    func printDebugInformation(data: Data, request: URLRequest, response: HTTPURLResponse) {
        guard printDebugInformation,
              let method = request.httpMethod,
              let urlString = request.url?.absoluteString else { return }

        print("<== \(response.statusCode) \(method) \(urlString)")

        print("HEADERS:")
        for header in response.allHeaderFields {
            print("\(header.key): \(header.value)")
        }

        if let responseString = String(data: data, encoding: .utf8) {
            print("RESPONSE:")
            print(responseString)
        }

        print("\n")
    }
}

public final class APIService: APIServiceProtocol {
    public let baseURL: URL
    public let session: URLSession
    public let printDebugInformation: Bool

    public init(baseURL: URL, session: URLSession, printDebugInformation: Bool) {
        self.baseURL = baseURL
        self.session = session
        self.printDebugInformation = printDebugInformation
    }
}

public struct EmptyBody: Encodable {}
