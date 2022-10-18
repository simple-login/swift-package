//
//  UpdateMailboxEndpoint.swift
//  Swift Package
//
//  Created by Nhon Proton on 18/10/2022.
//

import Foundation

// PUT /api/mailboxes/:mailbox_id
// https://github.com/simple-login/app/blob/master/docs/api.md#put-apimailboxesmailbox_id
public struct UpdateMailboxEndpoint: EndpointV2 {
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
