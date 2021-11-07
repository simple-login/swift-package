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

public extension AliasActivity {
    var id: UUID {
        UUID()
    }

    var date: Date {
        Date(timeIntervalSince1970: timestamp)
    }

    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.doesRelativeDateFormatting = true
        return formatter.string(from: date)
    }

    var relativeDateString: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.dateTimeStyle = .named
        return formatter.string(for: date) ?? ""
    }
}

public struct AliasActivityArray: Decodable {
    public let activities: [AliasActivity]
}
