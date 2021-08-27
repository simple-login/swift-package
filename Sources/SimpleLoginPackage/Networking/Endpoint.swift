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

// MARK: - Account
extension Endpoint {
    // MARK: - POST /api/auth/login
    // https://github.com/simple-login/app/blob/master/docs/api.md#post-apiauthlogin
    func login(email: String, password: String, device: String) -> URLRequest {
        let url = baseUrl.appending(path: "/api/auth/login")
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.post
        request.addJsonRequestBody(["email": email,
                                    "password": password,
                                    "device": device])
        return request
    }

    // MARK: - POST /api/auth/mfa
    // https://github.com/simple-login/app/blob/master/docs/api.md#post-apiauthmfa
    func mfa(token: String, key: String, device: String) -> URLRequest {
        let url = baseUrl.appending(path: "/api/auth/mfa")
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.post
        request.addJsonRequestBody(["mfa_token": token,
                                    "mfa_key": key,
                                    "device": device])
        return request
    }

    // MARK: - POST /api/auth/register
    // https://github.com/simple-login/app/blob/master/docs/api.md#post-apiauthregister
    func register(email: String, password: String) -> URLRequest {
        let url = baseUrl.appending(path: "/api/auth/register")
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.post
        request.addJsonRequestBody(["email": email, "password": password])
        return request
    }

    // MARK: - POST /api/auth/activate
    // https://github.com/simple-login/app/blob/master/docs/api.md#post-apiauthactivate
    /// Activate a newly registered email
    func activate(email: String, code: String) -> URLRequest {
        let url = baseUrl.appending(path: "/api/auth/activate")
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.post
        request.addJsonRequestBody(["email": email, "code": code])
        return request
    }
}
