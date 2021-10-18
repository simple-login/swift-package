//
//  MailboxUpdateOption.swift
//  Swift PackageTests
//
//  Created by Thanh-Nhon Nguyen on 18/10/2021.
//

import Foundation

public enum MailboxUpdateOption {
    case `default`
    case changeEmail(String)
    case cancelEmailChange

    public var requestBody: [String: Any] {
        switch self {
        case .default: return ["default": true]
        case .changeEmail(let newEmail): return ["email": newEmail]
        case .cancelEmailChange: return ["cancel_email_change": true]
        }
    }
}
