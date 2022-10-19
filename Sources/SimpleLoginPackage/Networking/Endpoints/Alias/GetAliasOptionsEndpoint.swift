//
//  GetAliasOptionsEndpoint.swift
//  Swift Package
//
//  Created by Nhon Proton on 17/10/2022.
//

import Foundation

// GET /api/v5/alias/options
// https://github.com/simple-login/app/blob/master/docs/api.md#get-apiv5aliasoptions
public struct GetAliasOptionsEndpoint: Endpoint {
    public typealias Body = EmptyBody
    public typealias Response = AliasOptions

    public var path: String
    public var method: HTTPMethod
    public var apiKey: String?

    public init(apiKey: String) {
        self.path = "/api/v5/alias/options"
        self.method = .get
        self.apiKey = apiKey
    }
}
