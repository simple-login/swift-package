//
//  ToggleAliasEndpoint.swift
//  Swift Package
//
//  Created by Nhon Proton on 17/10/2022.
//

import Foundation

// POST /api/aliases/:alias_id/toggle
// https://github.com/simple-login/app/blob/master/docs/api.md#post-apialiasesalias_idtoggle
public struct ToggleAliasEndpoint: Endpoint {
    public typealias Body = EmptyBody
    public typealias Response = EnabledResponse

    public var path: String
    public var method: HTTPMethod
    public var apiKey: String?

    public init(apiKey: String, aliasID: AliasID) {
        self.path = "/api/aliases/\(aliasID)/toggle"
        self.method = .post
        self.apiKey = apiKey
    }
}
