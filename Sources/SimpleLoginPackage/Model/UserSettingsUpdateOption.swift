//
//  UserSettingsUpdateOption.swift
//  Swift Package
//
//  Created by Thanh-Nhon Nguyen on 20/10/2021.
//

import Foundation

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

    var requestBody: [String: Any] {
        switch self {
        case .randomMode(let randomMode):
            return ["alias_generator": randomMode.rawValue]
        case .notification(let notification):
            return ["notification": notification]
        case .randomAliasDefaultDomain(let domain):
            return ["random_alias_default_domain": domain]
        case .senderFormat(let senderFormat):
            return ["sender_format": senderFormat.rawValue]
        case .randomAliasSuffix(let randomAliasSuffix):
            return ["random_alias_suffix": randomAliasSuffix.rawValue]
        }
    }
}
