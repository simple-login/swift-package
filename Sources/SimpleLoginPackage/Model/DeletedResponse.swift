//
//  DeletedResponse.swift
//  Swift Package
//
//  Created by Thanh-Nhon Nguyen on 13/10/2021.
//

import Foundation

/**
 Hold response from server when deleting something
 */
public struct DeletedResponse {
    public let value: Bool
}

extension DeletedResponse: Decodable {
    private enum Key: String, CodingKey {
        case value = "deleted"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        self.value = try container.decode(Bool.self, forKey: .value)
    }
}
