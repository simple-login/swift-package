//
//  GetUserSettingsEndpoint.swift
//  Swift Package
//
//  Created by Nhon Proton on 18/10/2022.
//

import Foundation

// GET /api/setting
// https://github.com/simple-login/app/blob/master/docs/api.md#get-apisetting
public struct GetUserSettingsEndpoint: Endpoint {
    public typealias Body = EmptyBody
    public typealias Response = UserSettings

    public var path: String
    public var method: HTTPMethod
    public var apiKey: String?

    public init(apiKey: String) {
        self.path = "/api/setting"
        self.method = .get
        self.apiKey = apiKey
    }
}
