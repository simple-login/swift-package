//
//  UpdateMailboxEndpoint.swift
//  Swift Package
//
//  Created by Nhon Proton on 18/10/2022.
//

import Foundation

// PUT /api/mailboxes/:mailbox_id
// https://github.com/simple-login/app/blob/master/docs/api.md#put-apimailboxesmailbox_id
public struct UpdateMailboxEndpoint: Endpoint {
    public typealias Body = MailboxUpdateOption
    public typealias Response = UpdateResponse

    public var path: String
    public var method: HTTPMethod
    public var apiKey: String?
    public var body: MailboxUpdateOption?

    public init(apiKey: String, mailboxID: MailboxID, option: MailboxUpdateOption) {
        self.path = "/api/mailboxes/\(mailboxID)"
        self.method = .put
        self.apiKey = apiKey
        self.body = option
    }
}

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
}
