//
//  DeletedAlias.swift
//  Swift Package
//
//  Created by Thanh-Nhon Nguyen on 19/10/2021.
//

import Foundation

public struct DeletedAlias {
    public let alias: String
    public let deletionTimestamp: TimeInterval
}

extension DeletedAlias: Decodable {
    private enum Key: String, CodingKey {
        case alias = "alias"
        case deletionTimestamp = "deletion_timestamp"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        self.alias = try container.decode(String.self, forKey: .alias)
        self.deletionTimestamp = try container.decode(TimeInterval.self, forKey: .deletionTimestamp)
    }
}
