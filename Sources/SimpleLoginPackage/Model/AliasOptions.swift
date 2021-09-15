//
//  AliasOptions.swift
//  Swift Package
//
//  Created by Thanh-Nhon Nguyen on 15/09/2021.
//

import Foundation

struct AliasOptions {
    let canCreate: Bool
    let prefixSuggestion: String
    let suffixes: [Suffix]
}

extension AliasOptions: Decodable {
    // swiftlint:disable:next type_name
    private enum Key: String, CodingKey {
        case canCreate = "can_create"
        case prefixSuggestion = "prefix_suggestion"
        case suffixes = "suffixes"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)

        self.canCreate = try container.decode(Bool.self, forKey: .canCreate)
        self.prefixSuggestion = try container.decode(String.self, forKey: .prefixSuggestion)
        self.suffixes = try container.decode([Suffix].self, forKey: .suffixes)
    }
}
