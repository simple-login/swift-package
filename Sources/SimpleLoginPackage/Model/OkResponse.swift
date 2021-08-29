//
//  OkResponse.swift
//  Swift Package
//
//  Created by Thanh-Nhon Nguyen on 27/08/2021.
//

import Foundation

// swiftlint:disable type_name
/**
 Hold response from server in cases like update alias's mailboxes
 */
public struct OkResponse: Decodable {
    let value: Bool

    private enum Key: String, CodingKey {
        case value = "ok"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)

        self.value = try container.decode(Bool.self, forKey: .value)
    }
}
