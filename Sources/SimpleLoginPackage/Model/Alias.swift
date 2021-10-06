//
//  Alias.swift
//  Swift Package
//
//  Created by Thanh-Nhon Nguyen on 30/05/2021.
//

import Foundation

public struct Alias {
    public let id: Int
    public let email: String
    public let name: String?
    public let enabled: Bool
    public let creationTimestamp: TimeInterval
    public let blockCount: Int
    public let forwardCount: Int
    public let replyCount: Int
    public let note: String?
    public let pgpSupported: Bool
    public let pgpDisabled: Bool
    public let mailboxes: [AliasMailbox]
    public let latestActivity: AliasActivity?
    public let pinned: Bool
}

extension Alias: Decodable {
    private enum Key: String, CodingKey {
        case id = "id"
        case email = "email"
        case name = "name"
        case enabled = "enabled"
        case creationTimestamp = "creation_timestamp"
        case blockCount = "nb_block"
        case forwardCount = "nb_forward"
        case replyCount = "nb_reply"
        case note = "note"
        case pgpSupported = "support_pgp"
        case pgpDisabled = "disable_pgp"
        case mailboxes = "mailboxes"
        case latestActivity = "latest_activity"
        case pinned = "pinned"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.email = try container.decode(String.self, forKey: .email)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.enabled = try container.decode(Bool.self, forKey: .enabled)
        self.creationTimestamp = try container.decode(TimeInterval.self, forKey: .creationTimestamp)
        self.blockCount = try container.decode(Int.self, forKey: .blockCount)
        self.forwardCount = try container.decode(Int.self, forKey: .forwardCount)
        self.replyCount = try container.decode(Int.self, forKey: .replyCount)
        self.note = try container.decodeIfPresent(String.self, forKey: .note)
        self.pgpSupported = try container.decode(Bool.self, forKey: .pgpSupported)
        self.pgpDisabled = try container.decode(Bool.self, forKey: .pgpDisabled)
        self.mailboxes = try container.decode([AliasMailbox].self, forKey: .mailboxes)
        self.latestActivity = try container.decodeIfPresent(AliasActivity.self, forKey: .latestActivity)
        self.pinned = try container.decode(Bool.self, forKey: .pinned)
    }
}
