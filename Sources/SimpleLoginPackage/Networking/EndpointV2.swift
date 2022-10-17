//
//  EndpointV2.swift
//  Swift Package
//
//  Created by Nhon Proton on 17/10/2022.
//

import Foundation

extension URL {
    func appending(path: String, queryItems: [URLQueryItem]? = nil) -> URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryItems

        guard let newUrl = components.url else {
            fatalError("""
                Error appending:
                - Path: \(path)
                - QueryItems: \(String(describing: queryItems))
                - To: \(self)
                """)
        }
        return newUrl
    }
}

public protocol EndpointV2 {
    associatedtype Body: Encodable
    associatedtype Response: Decodable

    var apiKey: ApiKey? { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var body: Body? { get }
    var parameters: [String: String?]? { get }

    func makeRequest(from baseURL: URL) throws -> URLRequest
}

public extension EndpointV2 {
    var apiKey: ApiKey? { nil }
    var method: HTTPMethod { .get }
    var parameters: [String: String?]? { nil }

    func makeRequest(from baseURL: URL) throws -> URLRequest {
        let url: URL
        if let parameters {
            let queryItems = parameters.map { URLQueryItem(name: $0, value: $1) }
            url = baseURL.appending(path: path, queryItems: queryItems)
        } else {
            url = baseURL.appending(path: path)
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if let body {
            request.httpBody = try JSONEncoder().encode(body)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        if let apiKey {
            request.addValue(apiKey.value, forHTTPHeaderField: "Authentication")
        }
        return request
    }
}
