//
//  UserSettings.swift
//  Swift Package
//
//  Created by Thanh-Nhon Nguyen on 20/10/2021.
//

import Foundation

public struct UserSettings: Decodable {
    public let randomMode: RandomMode
    public let notification: Bool
    public let randomAliasDefaultDomain: String
    public let senderFormat: SenderFormat
    public let randomAliasSuffix: RandomAliasSuffix

    private enum CodingKeys: String, CodingKey {
        case randomMode = "alias_generator"
        case notification = "notification"
        case randomAliasDefaultDomain = "random_alias_default_domain"
        case senderFormat = "sender_format"
        case randomAliasSuffix = "random_alias_suffix"
    }
}

public enum SenderFormat: String, Decodable, CaseIterable {
    // swiftlint:disable:next identifier_name
    case a = "A"
    case at = "AT"
    case nameOnly = "NAME_ONLY"
    case atOnly = "AT_ONLY"
    case noName = "NO_NAME"

    public var description: String {
        switch self {
        case .a: return "John Doe - john.doe(a)example.com"
        case .at: return "John Doe - john.doe at example.com"
        case .nameOnly: return "John Doe"
        case .atOnly: return "john at example.com"
        case .noName: return "No Name (i.e only reverse-alias)"
        }
    }
}

public enum RandomAliasSuffix: String, Decodable, CaseIterable {
    case word = "word"
    case randomString = "random_string"
}
