//
//  Suffix.swift
//  Swift Package
//
//  Created by Thanh-Nhon Nguyen on 15/09/2021.
//

import Foundation

public struct Suffix {
    public let value: String
    public let signature: String
}

extension Suffix: Decodable {
    private enum Key: String, CodingKey {
        case value = "suffix"
        case signature = "signed_suffix"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)

        self.value = try container.decode(String.self, forKey: .value)
        self.signature = try container.decode(String.self, forKey: .signature)
    }
}
