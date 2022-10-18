//
//  Alias.swift
//  Swift Package
//
//  Created by Thanh-Nhon Nguyen on 30/05/2021.
//

import Foundation

public typealias AliasID = Int

// swiftlint:disable function_default_parameter_at_end
public struct Alias {
    public let id: AliasID
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
    public let mailboxes: [MailboxLite]
    public let latestActivity: AliasLatestActivity?
    public let pinned: Bool

    public init(id: AliasID,
                email: String,
                name: String? = nil,
                enabled: Bool,
                creationTimestamp: TimeInterval,
                blockCount: Int,
                forwardCount: Int,
                replyCount: Int,
                note: String? = nil,
                pgpSupported: Bool,
                pgpDisabled: Bool,
                mailboxes: [MailboxLite],
                latestActivity: AliasLatestActivity? = nil,
                pinned: Bool) {
        self.id = id
        self.email = email
        self.name = name
        self.enabled = enabled
        self.creationTimestamp = creationTimestamp
        self.blockCount = blockCount
        self.forwardCount = forwardCount
        self.replyCount = replyCount
        self.note = note
        self.pgpSupported = pgpSupported
        self.pgpDisabled = pgpDisabled
        self.mailboxes = mailboxes
        self.latestActivity = latestActivity
        self.pinned = pinned
    }
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
        let mailboxes = try container.decode([MailboxLite].self, forKey: .mailboxes)
        self.mailboxes = mailboxes.sorted { $0.id < $1.id }
        self.latestActivity = try container.decodeIfPresent(AliasLatestActivity.self, forKey: .latestActivity)
        self.pinned = try container.decode(Bool.self, forKey: .pinned)
    }
}

public extension Alias {
    var mailboxesString: String {
        mailboxes.map { $0.email }.joined(separator: ", ")
    }

    var creationDate: Date {
        Date(timeIntervalSince1970: creationTimestamp)
    }

    var creationDateString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.doesRelativeDateFormatting = true
        return formatter.string(from: creationDate)
    }

    var relativeCreationDateString: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.dateTimeStyle = .named
        return formatter.string(for: creationDate) ?? ""
    }

    var noActivities: Bool {
        forwardCount + replyCount + blockCount == 0
    }
}

public struct AliasArray: Decodable {
    public let aliases: [Alias]
}

// For SwiftUI preview purpose
public extension Alias {
    static let random = Alias(id: 0,
                              email: "my.alias@simplelogin.co",
                              name: "John Doe",
                              enabled: true,
                              creationTimestamp: 1_635_277_847,
                              blockCount: 61,
                              forwardCount: 379,
                              replyCount: 17,
                              note: nil,
                              pgpSupported: false,
                              pgpDisabled: false,
                              mailboxes: [.johnDoe, .janeSmith],
                              latestActivity: nil,
                              pinned: true)
    static let ccohen = Alias(id: 1,
                              email: "ccohen@yahoo.ca",
                              name: "Chris Cohen",
                              enabled: true,
                              creationTimestamp: 1_635_277_847,
                              blockCount: 17,
                              forwardCount: 580,
                              replyCount: 3,
                              note: nil,
                              pgpSupported: true,
                              pgpDisabled: true,
                              mailboxes: [.frikazoyd, .grothoff],
                              latestActivity: nil,
                              pinned: false)

    static let claypool = Alias(id: 2,
                                email: "claypool@msn.com",
                                name: nil,
                                enabled: false,
                                creationTimestamp: 1_635_277_906,
                                blockCount: 893,
                                forwardCount: 12,
                                replyCount: 345,
                                note: "For online shopping",
                                pgpSupported: false,
                                pgpDisabled: false,
                                mailboxes: [.kmiller, .rafasgj, .scottlee, .grothoff],
                                latestActivity: .bounced,
                                pinned: true)
}
