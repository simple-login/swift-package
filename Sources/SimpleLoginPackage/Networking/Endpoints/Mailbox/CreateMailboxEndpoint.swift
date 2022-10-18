//
//  CreateMailboxEndpoint.swift
//  Swift Package
//
//  Created by Nhon Proton on 18/10/2022.
//

import Foundation

// POST /api/mailboxes
// https://github.com/simple-login/app/blob/master/docs/api.md#mailbox-endpoints
public struct CreateMailboxEndpoint: EndpointV2 {
    public typealias Body = CreateMailboxRequest
    public typealias Response = Mailbox

    public var path: String
    public var method: HTTPMethod
    public var apiKey: String?
    public var body: CreateMailboxRequest?

    public init(apiKey: String, email: String) {
        self.path = "/api/mailboxes"
        self.method = .post
        self.apiKey = apiKey
        self.body = .init(email: email)
    }
}

public struct CreateMailboxRequest: Encodable {
    let email: String
}
