//
//  EndpointV2.swift
//  Swift Package
//
//  Created by Nhon Proton on 17/10/2022.
//

import Foundation

public protocol EndpointV2 {
    associatedtype Body: Encodable
    associatedtype Response: Decodable

    var path: String { get }
    var method: HTTPMethod { get }
    var apiKey: String? { get }
    var body: Body? { get }
    var parameters: [String: String?]? { get }

    func makeRequest(from baseURL: URL) throws -> URLRequest
}

public extension EndpointV2 {
    var method: HTTPMethod { .get }
    var apiKey: String? { nil }
    var body: Body? { nil }
    var parameters: [String: String?]? { nil }

    func makeRequest(from baseURL: URL) throws -> URLRequest {
        var components = URLComponents()
        components.scheme = baseURL.scheme
        components.host = baseURL.host
        components.path = path
        if let parameters {
            components.queryItems = parameters.map { URLQueryItem(name: $0, value: $1) }
        }

        guard let url = components.url else {
            throw APIServiceError.failedToConstructURL(components)
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if let body {
            request.httpBody = try JSONEncoder().encode(body)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        if let apiKey {
            request.addValue(apiKey, forHTTPHeaderField: "Authentication")
        }
        return request
    }
}
