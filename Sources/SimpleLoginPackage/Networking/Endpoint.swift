//
//  Endpoint.swift
//  Swift PackageTests
//
//  Created by Thanh-Nhon Nguyen on 05/06/2021.
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

extension URLRequest {
    mutating func addApiKeyToHeaders(_ apiKey: ApiKey) {
        addValue(apiKey.value, forHTTPHeaderField: "Authentication")
    }

    mutating func addJsonRequestBody(_ dict: [String: Any?]) {
        httpBody = try? JSONSerialization.data(withJSONObject: dict)
        addValue("application/json", forHTTPHeaderField: "Content-Type")
    }
}

struct Endpoint {
    var baseUrl: URL
}

extension Endpoint {
    func login(email: String, password: String, device: String) -> URLRequest {
        let url = baseUrl.appending(path: "/api/auth/login")
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.post
        request.addJsonRequestBody(["email": email,
                                    "password": password,
                                    "device": device])
        return request
    }
}
