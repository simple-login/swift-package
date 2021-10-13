//
//  EnabledResponse.swift
//  Swift Package
//
//  Created by Thanh-Nhon Nguyen on 13/10/2021.
//

import Foundation

/**
 Hold response from server when enable/disable an alias
 */
public struct EnabledResponse {
    public let value: Bool
}

extension EnabledResponse: Decodable {
    private enum Key: String, CodingKey {
        case value = "enabled"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        self.value = try container.decode(Bool.self, forKey: .value)
    }
}
