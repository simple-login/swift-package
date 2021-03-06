//
//  UserSettingsUpdateOption.swift
//  Swift Package
//
//  Created by Thanh-Nhon Nguyen on 20/10/2021.
//

import Foundation

public enum UserSettingsUpdateOption {
    case randomMode(RandomMode)
    case notification(Bool)
    case randomAliasDefaultDomain(String)
    case senderFormat(SenderFormat)
    case randomAliasSuffix(RandomAliasSuffix)

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
