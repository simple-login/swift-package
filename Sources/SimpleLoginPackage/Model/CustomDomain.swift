//
//  CustomDomain.swift
//  Swift PackageTests
//
//  Created by Thanh-Nhon Nguyen on 18/10/2021.
//

import Foundation

public struct CustomDomain {
    public let id: Int
    public let creationTimestamp: TimeInterval
    public let domainName: String
    public let name: String?
    public let verified: Bool
    public let aliasCount: Int
    public let randomPrefixGeneration: Bool
    public let mailboxes: [MailboxLite]
    public let catchAll: Bool

    public init(id: Int,
                creationTimestamp: TimeInterval,
                domainName: String,
                name: String?,
                verified: Bool,
                aliasCount: Int,
                randomPrefixGeneration: Bool,
                mailboxes: [MailboxLite],
                catchAll: Bool) {
        self.id = id
        self.creationTimestamp = creationTimestamp
        self.domainName = domainName
        self.name = name
        self.verified = verified
        self.aliasCount = aliasCount
        self.randomPrefixGeneration = randomPrefixGeneration
        self.mailboxes = mailboxes
        self.catchAll = catchAll
    }
}

extension CustomDomain: Decodable {
    private enum Key: String, CodingKey {
        case id = "id"
        case creationTimestamp = "creation_timestamp"
        case domainName = "domain_name"
        case name = "name"
        case verified = "is_verified"
        case aliasCount = "nb_alias"
        case randomPrefixGeneration = "random_prefix_generation"
        case mailboxes = "mailboxes"
        case catchAll = "catch_all"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.creationTimestamp = try container.decode(TimeInterval.self, forKey: .creationTimestamp)
        self.domainName = try container.decode(String.self, forKey: .domainName)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.verified = try container.decode(Bool.self, forKey: .verified)
        self.aliasCount = try container.decode(Int.self, forKey: .aliasCount)
        self.randomPrefixGeneration = try container.decode(Bool.self, forKey: .randomPrefixGeneration)
        self.mailboxes = try container.decode([MailboxLite].self, forKey: .mailboxes)
        self.catchAll = try container.decode(Bool.self, forKey: .catchAll)
    }
}

// For SwiftUI preview purpose
public extension CustomDomain {
    static let verified = CustomDomain(id: 0,
                                       creationTimestamp: 1_641_852_987,
                                       domainName: "johndoe.info",
                                       name: "John Doe Domain",
                                       verified: true,
                                       aliasCount: 17,
                                       randomPrefixGeneration: true,
                                       mailboxes: [.frikazoyd, .grothoff],
                                       catchAll: true)

    static let unverified = CustomDomain(id: 1,
                                         creationTimestamp: 1_641_421_037,
                                         domainName: "janedoe.info",
                                         name: "Jane Doe Domain",
                                         verified: false,
                                         aliasCount: 87,
                                         randomPrefixGeneration: false,
                                         mailboxes: [.scottlee, .rafasgj],
                                         catchAll: false)
}
