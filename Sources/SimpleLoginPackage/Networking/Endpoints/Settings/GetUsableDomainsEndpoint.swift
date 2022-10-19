//
//  GetUsableDomainsEndpoint.swift
//  Swift Package
//
//  Created by Nhon Proton on 18/10/2022.
//

import Foundation

// GET /api/v2/setting/domains
// https://github.com/simple-login/app/blob/master/docs/api.md#get-apiv2settingdomains
public struct GetUsableDomainsEndpoint: Endpoint {
    public typealias Body = EmptyBody
    public typealias Response = [UsableDomain]

    public var path: String
    public var method: HTTPMethod
    public var apiKey: String?

    public init(apiKey: String) {
        self.path = "/api/v2/setting/domains"
        self.method = .get
        self.apiKey = apiKey
    }
}
