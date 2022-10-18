//
//  DeletedAlias.swift
//  Swift Package
//
//  Created by Thanh-Nhon Nguyen on 19/10/2021.
//

import Foundation

public struct DeletedAlias: Decodable {
    public let alias: String
    public let deletionTimestamp: TimeInterval

    private enum CodingKeys: String, CodingKey {
        case alias = "alias"
        case deletionTimestamp = "deletion_timestamp"
    }
}

public struct DeletedAliasArray: Decodable {
    public let aliases: [DeletedAlias]
}
