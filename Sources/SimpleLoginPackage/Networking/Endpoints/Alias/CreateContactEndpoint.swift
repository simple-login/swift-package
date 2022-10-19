//
//  CreateContactEndpoint.swift
//  Swift Package
//
//  Created by Nhon Proton on 18/10/2022.
//

import Foundation

// POST /api/aliases/:alias_id/contacts
// https://github.com/simple-login/app/blob/master/docs/api.md#post-apialiasesalias_idcontacts
public struct CreateContactEndpoint: Endpoint {
    public typealias Body = CreateContactRequest
    public typealias Response = Contact

    public var path: String
    public var method: HTTPMethod
    public var apiKey: String?
    public var body: CreateContactRequest?

    public init(apiKey: String, aliasID: AliasID, email: String) {
        self.path = "/api/aliases/\(aliasID)/contacts"
        self.method = .post
        self.apiKey = apiKey
        self.body = .init(email: email)
    }
}

public struct CreateContactRequest: Encodable {
    let email: String

    private enum CodingKeys: String, CodingKey {
        case email = "contact"
    }
}
