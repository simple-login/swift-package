//
//  AliasActivity.swift
//  Swift Package
//
//  Created by Thanh-Nhon Nguyen on 13/10/2021.
//

import Foundation

public struct AliasActivity {
    public let action: ActivityAction
    public let timestamp: TimeInterval
    public let from: String
    public let to: String
    public let reverseAlias: String // "\"marketing at example.com\" <reply@a.b>"
    public let reverseAliasAddress: String // "reply@a.b"
}

extension AliasActivity: Decodable {
    private enum Key: String, CodingKey {
        case action = "action"
        case timestamp = "timestamp"
        case from = "from"
        case to = "to"
        case reverseAlias = "reverse_alias"
        case reverseAliasAddress = "reverse_alias_address"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        self.action = try container.decode(ActivityAction.self, forKey: .action)
        self.timestamp = try container.decode(TimeInterval.self, forKey: .timestamp)
        self.from = try container.decode(String.self, forKey: .from)
        self.to = try container.decode(String.self, forKey: .to)
        self.reverseAlias = try container.decode(String.self, forKey: .reverseAlias)
        self.reverseAliasAddress = try container.decode(String.self, forKey: .reverseAliasAddress)
    }
}

public struct AliasActivityArray: Decodable {
    public let activities: [AliasActivity]
}

// For SwiftUI preview purpose
public extension AliasActivity {
    static let block = AliasActivity(action: .block,
                                     timestamp: 1_636_294_781,
                                     from: "crimsane@att.net",
                                     to: "godeke@sbcglobal.net",
                                     reverseAlias: "Reversed Crimsane <reversed.crimsane@att.net>",
                                     reverseAliasAddress: "reversed.crimsane@att.net")

    static let bounced = AliasActivity(action: .bounced,
                                       timestamp: 1_636_294_840,
                                       from: "tromey@gmail.com",
                                       to: "uqmcolyv@comcast.net",
                                       reverseAlias: "Reversed Tromey <reversed.tromey@gmail.com>",
                                       reverseAliasAddress: "reversed.tromey@gmail.com")

    static let forward = AliasActivity(action: .forward,
                                       timestamp: 1_636_294_874,
                                       from: "grady@me.com",
                                       to: "shaffei@hotmail.com",
                                       reverseAlias: "Reversed Grady <reversed.grady@me.com>",
                                       reverseAliasAddress: "reversed.grady@me.com")

    static let reply = AliasActivity(action: .reply,
                                     timestamp: 1_636_294_908,
                                     from: "ewaters@yahoo.ca",
                                     to: "uraeus@gmail.com",
                                     reverseAlias: "Reversed Waters <reversed.ewaters@yahoo.ca>",
                                     reverseAliasAddress: "reversed.ewaters@yahoo.ca")
}
