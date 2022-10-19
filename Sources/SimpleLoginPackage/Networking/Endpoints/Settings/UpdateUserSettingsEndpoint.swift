//
//  UpdateUserSettingsEndpoint.swift
//  Swift Package
//
//  Created by Nhon Proton on 18/10/2022.
//

import Foundation

// PATCH /api/setting
// https://github.com/simple-login/app/blob/master/docs/api.md#patch-apisetting
public struct UpdateUserSettingsEndpoint: Endpoint {
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

public enum UserSettingsUpdateOption: Encodable {
    case randomMode(RandomMode)
    case notification(Bool)
    case randomAliasDefaultDomain(String)
    case senderFormat(SenderFormat)
    case randomAliasSuffix(RandomAliasSuffix)

    private enum CodingKeys: String, CodingKey {
        case randomMode = "alias_generator"
        case notification = "notification"
        case randomAliasDefaultDomain = "random_alias_default_domain"
        case senderFormat = "sender_format"
        case randomAliasSuffix = "random_alias_suffix"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .randomMode(let randomMode):
            try container.encode(randomMode.rawValue, forKey: .randomMode)
        case .notification(let notification):
            try container.encode(notification, forKey: .notification)
        case .randomAliasDefaultDomain(let domain):
            try container.encode(domain, forKey: .randomAliasDefaultDomain)
        case .senderFormat(let senderFormat):
            try container.encode(senderFormat.rawValue, forKey: .senderFormat)
        case .randomAliasSuffix(let randomAliasSuffix):
            try container.encode(randomAliasSuffix.rawValue, forKey: .randomAliasSuffix)
        }
    }
}
