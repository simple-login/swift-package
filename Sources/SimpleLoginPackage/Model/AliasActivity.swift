//
//  AliasActivity.swift
//  Swift Package
//
//  Created by Thanh-Nhon Nguyen on 13/10/2021.
//

import Foundation

public struct AliasActivity: Decodable {
    public let action: ActivityAction
    public let timestamp: TimeInterval
    public let from: String
    public let to: String
    public let reverseAlias: String // "\"marketing at example.com\" <reply@a.b>"
    public let reverseAliasAddress: String // "reply@a.b"

    private enum CodingKeys: String, CodingKey {
        case action = "action"
        case timestamp = "timestamp"
        case from = "from"
        case to = "to"
        case reverseAlias = "reverse_alias"
        case reverseAliasAddress = "reverse_alias_address"
    }
}

public extension AliasActivity {
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
