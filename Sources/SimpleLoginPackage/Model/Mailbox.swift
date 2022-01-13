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

    public init(id: Int,
                email: String,
                default: Bool,
                creationTimestamp: TimeInterval,
                aliasCount: Int,
                verified: Bool) {
        self.id = id
        self.email = email
        self.default = `default`
        self.creationTimestamp = creationTimestamp
        self.aliasCount = aliasCount
        self.verified = verified
    }
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

public extension Mailbox {
    var creationDate: Date {
        Date(timeIntervalSince1970: creationTimestamp)
    }

    var relativeCreationDateString: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.dateTimeStyle = .named
        return formatter.string(for: creationDate) ?? ""
    }
}

// For SwiftUI preview purpose
public extension Mailbox {
    static let defaultVerified = Mailbox(id: 0,
                                         email: "john.doe@example.com",
                                         default: true,
                                         creationTimestamp: 1_641_852_987,
                                         aliasCount: 10,
                                         verified: true)

    static let normalVerified = Mailbox(id: 0,
                                        email: "jane.doe@example.com",
                                        default: false,
                                        creationTimestamp: 1_641_075_437,
                                        aliasCount: 20,
                                        verified: true)

    static let normalUnverified = Mailbox(id: 0,
                                          email: "jill.doe@example.com",
                                          default: false,
                                          creationTimestamp: 1_641_421_037,
                                          aliasCount: 30,
                                          verified: false)
}
