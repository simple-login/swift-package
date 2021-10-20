//
//  UserSettings.swift
//  Swift Package
//
//  Created by Thanh-Nhon Nguyen on 20/10/2021.
//

import Foundation

public struct UserSettings {
    public let randomMode: RandomMode
    public let notification: Bool
    public let randomAliasDefaultDomain: String
    public let senderFormat: SenderFormat
}

extension UserSettings: Decodable {
    private enum Key: String, CodingKey {
        case randomMode = "alias_generator"
        case notification = "notification"
        case randomAliasDefaultDomain = "random_alias_default_domain"
        case senderFormat = "sender_format"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        self.randomMode = try container.decode(RandomMode.self, forKey: .randomMode)
        self.notification = try container.decode(Bool.self, forKey: .notification)
        self.randomAliasDefaultDomain = try container.decode(String.self, forKey: .randomAliasDefaultDomain)
        self.senderFormat = try container.decode(SenderFormat.self, forKey: .senderFormat)
    }
}

public enum SenderFormat: String, Decodable, CaseIterable {
    // swiftlint:disable:next identifier_name
    case a = "A"
    case at = "AT"

    public var description: String {
        switch self {
        case .a: return "John Doe - john.doe(a)example.com"
        case .at: return "John Doe - john.doe at example.com"
        }
    }
}
