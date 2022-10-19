//
//  GetAliasEndpoint.swift
//  Swift Package
//
//  Created by Nhon Proton on 17/10/2022.
//

import Foundation

// GET /api/aliases/:alias_id
// https://github.com/simple-login/app/blob/master/docs/api.md#get-apialiasesalias_id
public struct GetAliasEndpoint: Endpoint {
    public typealias Body = EmptyBody
    public typealias Response = Alias

    public var path: String
    public var method: HTTPMethod
    public var apiKey: String?

    public init(apiKey: String, aliasID: AliasID) {
        self.path = "/api/aliases/\(aliasID)"
        self.method = .get
        self.apiKey = apiKey
    }
}
