//
//  GetContactsEndpoint.swift
//  Swift Package
//
//  Created by Nhon Proton on 18/10/2022.
//

import Foundation

// GET /api/aliases/:alias_id/contacts
// https://github.com/simple-login/app/blob/master/docs/api.md#get-apialiasesalias_idcontacts
public struct GetContactsEndpoint: Endpoint {
    public typealias Body = EmptyBody
    public typealias Response = ContactArray

    public var path: String
    public var method: HTTPMethod
    public var apiKey: String?
    public var parameters: [String: String?]?

    public init(apiKey: String, aliasID: AliasID, page: Int) {
        self.path = "/api/aliases/\(aliasID)/contacts"
        self.method = .get
        self.apiKey = apiKey
        self.parameters = ["page_id": "\(page)"]
    }
}
