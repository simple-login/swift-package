//
//  GetDeletedAliasesEndpoint.swift
//  Swift Package
//
//  Created by Nhon Proton on 18/10/2022.
//

import Foundation

// GET /api/custom_domains/:custom_domain_id/trash
// https://github.com/simple-login/app/blob/master/docs/api.md#get-apicustom_domainscustom_domain_idtrash
public struct GetDeletedAliasesEndpoint: EndpointV2 {
    public typealias Body = EmptyBody
    public typealias Response = DeletedAliasArray

    public var path: String
    public var method: HTTPMethod
    public var apiKey: String?

    public init(apiKey: String, customDomainID: CustomDomainID) {
        self.path = "/api/custom_domains/\(customDomainID)/trash"
        self.method = .get
        self.apiKey = apiKey
    }
}
