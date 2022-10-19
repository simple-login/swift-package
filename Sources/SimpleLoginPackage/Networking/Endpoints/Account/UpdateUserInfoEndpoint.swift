//
//  UpdateUserInfoEndpoint.swift
//  Swift Package
//
//  Created by Nhon Proton on 18/10/2022.
//

import Foundation

// PATCH /api/user_info
// https://github.com/simple-login/app/blob/master/docs/api.md#patch-apiuser_info
public struct UpdateUserInfoEndpoint: Endpoint {
    public typealias Body = UpdateUserInfoOption
    public typealias Response = UserInfo

    public var path: String
    public var method: HTTPMethod
    public var apiKey: String?
    public var body: UpdateUserInfoOption?

    public init(apiKey: String, option: UpdateUserInfoOption) {
        self.path = "/api/user_info"
        self.method = .patch
        self.apiKey = apiKey
        self.body = option
    }
}

public enum UpdateUserInfoOption: Encodable {
    case profilePicture(String?)
    case name(String?)

    private enum CodingKeys: String, CodingKey {
        case profilePicture = "profile_picture"
        case name = "name"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .profilePicture(let profilePicture):
            try container.encode(profilePicture, forKey: .profilePicture)
        case .name(let name):
            try container.encode(name, forKey: .name)
        }
    }
}
