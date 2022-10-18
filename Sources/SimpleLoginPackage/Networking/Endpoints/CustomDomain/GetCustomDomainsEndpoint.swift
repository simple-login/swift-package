//
//  GetCustomDomainsEndpoint.swift
//  Swift Package
//
//  Created by Nhon Proton on 18/10/2022.
//

import Foundation

// GET /api/custom_domains
// https://github.com/simple-login/app/blob/master/docs/api.md#get-apicustom_domains
public struct GetCustomDomainsEndpoint: EndpointV2 {
    public typealias Body = EmptyBody
    public typealias Response = CustomDomainArray

    public var path: String
    public var method: HTTPMethod
    public var apiKey: String?

    public init(apiKey: String) {
        self.path = "/api/custom_domains"
        self.method = .get
        self.apiKey = apiKey
    }
}
