//
//  ApiKey.swift
//  Swift Package
//
//  Created by Thanh-Nhon Nguyen on 04/06/2021.
//

import Foundation

public struct ApiKey {
    let value: String
}

extension ApiKey: Decodable {
    // swiftlint:disable:next type_name
    private enum Key: String, CodingKey {
        case value = "api_key"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        self.value = try container.decode(String.self, forKey: .value)
    }
}
