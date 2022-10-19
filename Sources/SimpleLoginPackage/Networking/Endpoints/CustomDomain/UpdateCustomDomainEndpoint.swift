//
//  UpdateCustomDomainEndpoint.swift
//  Swift Package
//
//  Created by Nhon Proton on 18/10/2022.
//

import Foundation

// PATCH /api/custom_domains/:custom_domain_id
// https://github.com/simple-login/app/blob/master/docs/api.md#patch-apicustom_domainscustom_domain_id
public struct UpdateCustomDomainEndpoint: Endpoint {
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

public enum CustomDomainUpdateOption: Encodable {
    case catchAll(Bool)
    case randomPrefixGeneration(Bool)
    case name(String?)
    case mailboxIds([Int])

    private enum CodingKeys: String, CodingKey {
        case catchAll = "catch_all"
        case randomPrefixGeneration = "random_prefix_generation"
        case name = "name"
        case mailboxIds = "mailbox_ids"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .catchAll(let enabled):
            try container.encode(enabled, forKey: .catchAll)
        case .randomPrefixGeneration(let enabled):
            try container.encode(enabled, forKey: .randomPrefixGeneration)
        case .name(let name):
            try container.encode(name, forKey: .name)
        case .mailboxIds(let ids):
            try container.encode(ids, forKey: .mailboxIds)
        }
    }
}

public struct CustomDomainUpdateResponse: Decodable {
    public let customDomain: CustomDomain

    private enum CodingKeys: String, CodingKey {
        case customDomain = "custom_domain"
    }
}
