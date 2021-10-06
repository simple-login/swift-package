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

    // MARK: - POST /api/auth/reactivate
    // https://github.com/simple-login/app/blob/master/docs/api.md#post-apiauthreactivate
    func reactivate(email: String) -> URLRequest {
        let url = baseUrl.appending(path: "/api/auth/reactivate")
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.post
        request.addJsonRequestBody(["email": email])
        return request
    }

    // MARK: - POST /api/auth/forgot_password
    // https://github.com/simple-login/app/blob/master/docs/api.md#post-apiauthforgot_password
    func forgotPassword(email: String) -> URLRequest {
        let url = baseUrl.appending(path: "/api/auth/forgot_password")
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.post
        request.addJsonRequestBody(["email": email])
        return request
    }

    // MARK: - GET /api/user_info
    // https://github.com/simple-login/app/blob/master/docs/api.md#get-apiuser_info
    func getUserInfo(apiKey: ApiKey) -> URLRequest {
        let url = baseUrl.appending(path: "/api/user_info")
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.get
        request.addApiKeyToHeaders(apiKey)
        return request
    }

    // MARK: - PATCH /api/user_info
    // https://github.com/simple-login/app/blob/master/docs/api.md#patch-apiuser_info
    func updateProfilePicture(apiKey: ApiKey, profilePicture: String?) -> URLRequest {
        let url = baseUrl.appending(path: "/api/user_info")
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.patch
        request.addApiKeyToHeaders(apiKey)
        request.addJsonRequestBody(["profile_picture": profilePicture])
        return request
    }

    func updateProfileName(apiKey: ApiKey, name: String?) -> URLRequest {
        let url = baseUrl.appending(path: "/api/user_info")
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.patch
        request.addApiKeyToHeaders(apiKey)
        request.addJsonRequestBody(["name": name])
        return request
    }
}

// MARK: - Alias
extension Endpoint {
    // MARK: - GET /api/v5/alias/options
    // https://github.com/simple-login/app/blob/master/docs/api.md#get-apiv5aliasoptions
    func getAliasOptions(apiKey: ApiKey, hostname: String?) -> URLRequest {
        let path = "/api/v5/alias/options"
        let url: URL
        if let hostname = hostname {
            url = baseUrl.appending(path: path, queryItems: [.init(name: "hostname", value: hostname)])
        } else {
            url = baseUrl.appending(path: path)
        }
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.get
        request.addApiKeyToHeaders(apiKey)
        return request
    }

    // MARK: - POST /api/v3/alias/custom/new
    // https://github.com/simple-login/app/blob/master/docs/api.md#post-apiv3aliascustomnew
    func createAlias(apiKey: ApiKey, options: AliasCreationOptions) -> URLRequest {
        let url = baseUrl.appending(path: "/api/v3/alias/custom/new", queryItems: [options.queryItem()])
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.post
        request.addApiKeyToHeaders(apiKey)
        request.addJsonRequestBody(options.requestBody())
        return request
    }
}
