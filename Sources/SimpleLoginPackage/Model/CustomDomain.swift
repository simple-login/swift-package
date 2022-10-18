//
//  CustomDomain.swift
//  Swift PackageTests
//
//  Created by Thanh-Nhon Nguyen on 18/10/2021.
//

import Foundation

public typealias CustomDomainID = Int

// swiftlint:disable function_default_parameter_at_end
public struct CustomDomain: Decodable {
    public let id: CustomDomainID
    public let creationTimestamp: TimeInterval
    public let domainName: String
    public let name: String?
    public let verified: Bool
    public let aliasCount: Int
    public let randomPrefixGeneration: Bool
    public let mailboxes: [MailboxLite]
    public let catchAll: Bool

    private enum CodingKeys: String, CodingKey {
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

    public init(id: CustomDomainID,
                creationTimestamp: TimeInterval,
                domainName: String,
                name: String? = nil,
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

public extension CustomDomain {
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
}

public struct CustomDomainArray: Decodable {
    public let customDomains: [CustomDomain]

    private enum CodingKeys: String, CodingKey {
        case customDomains = "custom_domains"
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
