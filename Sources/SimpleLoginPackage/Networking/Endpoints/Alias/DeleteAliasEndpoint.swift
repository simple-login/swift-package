//
//  DeleteAliasEndpoint.swift
//  Swift Package
//
//  Created by Nhon Proton on 17/10/2022.
//

import Foundation

// DELETE /api/aliases/:alias_id
// https://github.com/simple-login/app/blob/master/docs/api.md#delete-apialiasesalias_id
public struct DeleteAliasEndpoint: EndpointV2 {
    public typealias Body = EmptyBody
    public typealias Response = DeletedResponse

    public var path: String
    public var method: HTTPMethod
    public var apiKey: String?

    public init(apiKey: String, aliasID: AliasID) {
        self.path = "/api/aliases/\(aliasID)"
        self.method = .delete
        self.apiKey = apiKey
    }
}
