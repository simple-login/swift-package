//
//  AliasCreationOptions.swift
//  Swift PackageTests
//
//  Created by Thanh-Nhon Nguyen on 06/10/2021.
//

import Foundation

public struct AliasCreationOptions {
    public let hostname: String?
    public let prefix: String
    public let suffix: Suffix
    public let mailboxIds: [Int]
    public let note: String?
    public let name: String?

    public init(hostname: String?,
                prefix: String,
                suffix: Suffix,
                mailboxIds: [Int],
                note: String?,
                name: String?) {
        self.hostname = hostname
        self.prefix = prefix
        self.suffix = suffix
        self.mailboxIds = mailboxIds
        self.note = note
        self.name = name
    }

    public func requestBody() -> [String: Any?] {
        ["alias_prefix": prefix,
         "signed_suffix": suffix.signature,
         "mailbox_ids": mailboxIds,
         "note": note,
         "name": name]
    }

    public func queryItem() -> URLQueryItem {
        .init(name: "hostname", value: hostname)
    }
}
