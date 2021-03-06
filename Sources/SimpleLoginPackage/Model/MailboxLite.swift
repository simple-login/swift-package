//
//  AliasMailbox.swift
//  Swift Package
//
//  Created by Thanh-Nhon Nguyen on 06/10/2021.
//

import Foundation

public struct MailboxLite: Decodable {
    public let id: Int
    public let email: String

    public init(id: Int, email: String) {
        self.id = id
        self.email = email
    }
}

// For SwiftUI preview purpose
public extension MailboxLite {
    static let johnDoe      = MailboxLite(id: 0, email: "john.doe@example.com")
    static let janeSmith    = MailboxLite(id: 1, email: "jane.smith@domain.com")
    static let kmiller      = MailboxLite(id: 2, email: "kmiller@msn.com")
    static let grothoff     = MailboxLite(id: 3, email: "grothoff@yahoo.ca")
    static let frikazoyd    = MailboxLite(id: 4, email: "frikazoyd@aol.com")
    static let rafasgj      = MailboxLite(id: 5, email: "rafasgj@sbcglobal.net")
    static let scottlee     = MailboxLite(id: 6, email: "scottlee@icloud.com")
}
