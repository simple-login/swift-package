//
//  GetMailboxesEndpoint.swift
//  Swift Package
//
//  Created by Nhon Proton on 17/10/2022.
//

import Foundation

// GET /api/v2/mailboxes
// https://github.com/simple-login/app/blob/master/docs/api.md#get-apiv2mailboxes
public struct GetMailboxesEndpoint: Endpoint {
    public typealias Body = EmptyBody
    public typealias Response = MailboxArray

    public var path: String
    public var method: HTTPMethod
    public var apiKey: String?

    public init(apiKey: String) {
        self.path = "/api/v2/mailboxes"
        self.method = .get
        self.apiKey = apiKey
    }
}
