//
//  MailboxUpdateOption.swift
//  Swift PackageTests
//
//  Created by Thanh-Nhon Nguyen on 18/10/2021.
//

import Foundation

public enum MailboxUpdateOption: Encodable {
    case `default`
    case changeEmail(String)
    case cancelEmailChange

    private enum CodingKeys: String, CodingKey {
        case `default` = "default"
        case changeEmail = "email"
        case cancelEmailChange = "cancel_email_change"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .default:
            try container.encode(true, forKey: .default)
        case .changeEmail(let newEmail):
            try container.encode(newEmail, forKey: .changeEmail)
        case .cancelEmailChange:
            try container.encode(true, forKey: .cancelEmailChange)
        }
    }

    public var requestBody: [String: Any] {
        switch self {
        case .default: return ["default": true]
        case .changeEmail(let newEmail): return ["email": newEmail]
        case .cancelEmailChange: return ["cancel_email_change": true]
        }
    }
}
