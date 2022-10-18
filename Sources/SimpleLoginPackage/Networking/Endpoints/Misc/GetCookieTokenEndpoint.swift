//
//  GetCookieTokenEndpoint.swift
//  Swift Package
//
//  Created by Nhon Proton on 18/10/2022.
//

import Foundation

// MARK: - GET /api/user/cookie_token
// https://github.com/simple-login/app/blob/master/docs/api.md#get-apiusercookie_token
public struct GetCookieTokenEndpoint: EndpointV2 {
    public typealias Body = EmptyBody
    public typealias Response = Token

    public var path: String
    public var method: HTTPMethod
    public var apiKey: String?

    public init(apiKey: String) {
        self.path = "/api/user/cookie_token"
        self.method = .get
        self.apiKey = apiKey
    }
}
