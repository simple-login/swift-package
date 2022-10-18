//
//  UpdateUserSettingsEndpoint.swift
//  Swift Package
//
//  Created by Nhon Proton on 18/10/2022.
//

import Foundation

// PATCH /api/setting
// https://github.com/simple-login/app/blob/master/docs/api.md#patch-apisetting
public struct UpdateUserSettingsEndpoint: EndpointV2 {
    public typealias Body = UserSettingsUpdateOption
    public typealias Response = UserSettings

    public var path: String
    public var method: HTTPMethod
    public var apiKey: String?
    public var body: UserSettingsUpdateOption?

    public init(apiKey: String, option: UserSettingsUpdateOption) {
        self.path = "/api/setting"
        self.method = .patch
        self.apiKey = apiKey
        self.body = option
    }
}
