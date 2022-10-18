//
//  Mailbox.swift
//  Swift Package
//
//  Created by Thanh-Nhon Nguyen on 18/10/2021.
//

import Foundation

public typealias MailboxID = Int

public struct Mailbox: Decodable {
    public let id: MailboxID
    public let email: String
    public let `default`: Bool
    public let creationTimestamp: TimeInterval
    public let aliasCount: Int
    public let verified: Bool

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case email = "email"
        case `default` = "default"
        case creationTimestamp = "creation_timestamp"
        case aliasCount = "nb_alias"
        case verified = "verified"
    }

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
