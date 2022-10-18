//
//  GetUserInfoEndpoint.swift
//  Swift Package
//
//  Created by Nhon Proton on 17/10/2022.
//

import Foundation

// GET /api/user_info
// https://github.com/simple-login/app/blob/master/docs/api.md#get-apiuser_info
public struct GetUserInfoEndpoint: EndpointV2 {
    public typealias Body = EmptyBody
    public typealias Response = UserInfo

    public var path: String
    public var method: HTTPMethod
    public var apiKey: String?

    public init(apiKey: String) {
        self.path = "/api/user_info"
        self.method = .get
        self.apiKey = apiKey
    }
}
