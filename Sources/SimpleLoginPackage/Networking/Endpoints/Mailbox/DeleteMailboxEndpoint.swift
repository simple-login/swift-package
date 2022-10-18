//
//  DeleteMailboxEndpoint.swift
//  Swift Package
//
//  Created by Nhon Proton on 18/10/2022.
//

import Foundation

// DELETE /api/mailboxes/:mailbox_id
// https://github.com/simple-login/app/blob/master/docs/api.md#delete-apimailboxesmailbox_id
public struct DeleteMailboxEndpoint: EndpointV2 {
    public typealias Body = DeleteMailboxRequest
    public typealias Response = DeletedResponse

    public var path: String
    public var method: HTTPMethod
    public var apiKey: String?
    public var body: DeleteMailboxRequest?

    public init(apiKey: String, mailboxID: MailboxID) {
        self.path = "/api/mailboxes/\(mailboxID)"
        self.method = .delete
        self.apiKey = apiKey
        self.body = .init(mailboxID: mailboxID)
    }
}

public struct DeleteMailboxRequest: Encodable {
    let mailboxID: MailboxID
}
