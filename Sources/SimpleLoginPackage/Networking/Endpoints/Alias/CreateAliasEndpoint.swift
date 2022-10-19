//
//  CreateAliasEndpoint.swift
//  Swift Package
//
//  Created by Nhon Proton on 17/10/2022.
//

import Foundation

// POST /api/v3/alias/custom/new
// https://github.com/simple-login/app/blob/master/docs/api.md#post-apiv3aliascustomnew
public struct CreateAliasEndpoint: Endpoint {
    public typealias Body = CreateAliasRequest
    public typealias Response = Alias

    public var path: String
    public var method: HTTPMethod
    public var apiKey: String?
    public var body: CreateAliasRequest?
    public var parameters: [String: String?]?

    public init(apiKey: String, request: CreateAliasRequest, hostname: String?) {
        self.path = "/api/v3/alias/custom/new"
        self.method = .post
        self.apiKey = apiKey
        self.body = request
        self.parameters = ["hostname": hostname]
    }
}

public struct CreateAliasRequest: Encodable {
    let prefix: String
    let signedSuffix: String
    let mailboxIds: [Int]
    let note: String?
    let name: String?

    private enum CodingKeys: String, CodingKey {
        case prefix = "alias_prefix"
        case signedSuffix = "signed_suffix"
        case mailboxIds = "mailbox_ids"
        case note = "note"
        case name = "name"
    }

    public init(prefix: String,
                suffix: Suffix,
                mailboxIds: [Int],
                note: String?,
                name: String?) {
        self.prefix = prefix
        self.signedSuffix = suffix.signature
        self.mailboxIds = mailboxIds
        self.note = note
        self.name = name
    }
}
