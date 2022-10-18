//
//  UpdateAliasEndpoint.swift
//  Swift Package
//
//  Created by Nhon Proton on 18/10/2022.
//

import Foundation

// PATCH /api/aliases/:alias_id
// https://github.com/simple-login/app/blob/master/docs/api.md#patch-apialiasesalias_id
public struct UpdateAliasEndpoint: EndpointV2 {
    public typealias Body = AliasUpdateOption
    public typealias Response = OkResponse

    public var path: String
    public var method: HTTPMethod
    public var apiKey: String?
    public var body: AliasUpdateOption?

    public init(apiKey: String, aliasID: AliasID, option: AliasUpdateOption) {
        self.path = "/api/aliases/\(aliasID)"
        self.method = .patch
        self.apiKey = apiKey
        self.body = option
    }
}
