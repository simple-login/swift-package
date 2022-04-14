//
//  AliasOptions.swift
//  Swift Package
//
//  Created by Thanh-Nhon Nguyen on 15/09/2021.
//

import Foundation

public struct AliasOptions: Decodable {
    public let canCreate: Bool
    public let prefixSuggestion: String
    public let suffixes: [Suffix]

    private enum CodingKeys: String, CodingKey {
        case canCreate = "can_create"
        case prefixSuggestion = "prefix_suggestion"
        case suffixes = "suffixes"
    }
}
