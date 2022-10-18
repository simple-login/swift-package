//
//  UpdateCustomDomainEndpoint.swift
//  Swift Package
//
//  Created by Nhon Proton on 18/10/2022.
//

import Foundation

// PATCH /api/custom_domains/:custom_domain_id
// https://github.com/simple-login/app/blob/master/docs/api.md#patch-apicustom_domainscustom_domain_id
public struct UpdateCustomDomainEndpoint: EndpointV2 {
    public typealias Body = CustomDomainUpdateOption
    public typealias Response = CustomDomainUpdateResponse

    public var path: String
    public var method: HTTPMethod
    public var apiKey: String?
    public var body: CustomDomainUpdateOption?

    public init(apiKey: String,
                customDomainID: CustomDomainID,
                option: CustomDomainUpdateOption) {
        self.path = "/api/custom_domains/\(customDomainID)"
        self.method = .patch
        self.apiKey = apiKey
        self.body = option
    }
}
