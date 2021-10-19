//
//  CustomDomainUpdateOption.swift
//  Swift Package
//
//  Created by Thanh-Nhon Nguyen on 19/10/2021.
//

import Foundation

public enum CustomDomainUpdateOption {
    case catchAll(Bool)
    case randomPrefixGeneration(Bool)
    case name(String?)
    case mailboxIds([Int])

    public var requestBody: [String: Any?] {
        switch self {
        case .catchAll(let catchAll): return ["catch_all": catchAll]
        case .randomPrefixGeneration(let random): return ["random_prefix_generation": random]
        case .name(let name): return ["name": name]
        case .mailboxIds(let ids): return ["mailbox_ids": ids]
        }
    }
}
