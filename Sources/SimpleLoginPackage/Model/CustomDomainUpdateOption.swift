//
//  CustomDomainUpdateOption.swift
//  Swift Package
//
//  Created by Thanh-Nhon Nguyen on 19/10/2021.
//

import Foundation

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

    public var requestBody: [String: Any?] {
        switch self {
        case .catchAll(let catchAll): return ["catch_all": catchAll]
        case .randomPrefixGeneration(let random): return ["random_prefix_generation": random]
        case .name(let name): return ["name": name]
        case .mailboxIds(let ids): return ["mailbox_ids": ids]
        }
    }
}

public struct CustomDomainUpdateResponse: Decodable {
    public let customDomain: CustomDomain

    private enum CodingKeys: String, CodingKey {
        case customDomain = "custom_domain"
    }
}
