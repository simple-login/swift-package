//
//  Suffix.swift
//  Swift Package
//
//  Created by Thanh-Nhon Nguyen on 15/09/2021.
//

import Foundation

struct Suffix {
    let value: String
    let signature: String
}

extension Suffix: Decodable {
    // swiftlint:disable:next type_name
    private enum Key: String, CodingKey {
        case value = "suffix"
        case signature = "signed_suffix"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)

        self.value = try container.decode(String.self, forKey: .value)
        self.signature = try container.decode(String.self, forKey: .signature)
    }
}
