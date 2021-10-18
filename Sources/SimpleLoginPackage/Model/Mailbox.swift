//
//  Mailbox.swift
//  Swift Package
//
//  Created by Thanh-Nhon Nguyen on 18/10/2021.
//

import Foundation

public struct Mailbox {
    public let id: Int
    public let email: String
    public let `default`: Bool
    public let creationTimestamp: TimeInterval
    public let aliasCount: Int
    public let verified: Bool
}

extension Mailbox: Decodable {
    private enum Key: String, CodingKey {
        case id = "id"
        case email = "email"
        case `default` = "default"
        case creationTimestamp = "creation_timestamp"
        case aliasCount = "nb_alias"
        case verified = "verified"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.email = try container.decode(String.self, forKey: .email)
        self.default = try container.decode(Bool.self, forKey: .default)
        self.creationTimestamp = try container.decode(TimeInterval.self, forKey: .creationTimestamp)
        self.aliasCount = try container.decode(Int.self, forKey: .aliasCount)
        self.verified = try container.decode(Bool.self, forKey: .verified)
    }
}

public struct MailboxArray: Decodable {
    public let mailboxes: [Mailbox]
}
