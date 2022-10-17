//
//  DeletedResponse.swift
//  Swift Package
//
//  Created by Thanh-Nhon Nguyen on 13/10/2021.
//

import Foundation

/// Hold response from server when deleting something
public struct DeletedResponse: Decodable {
    public let value: Bool

    private enum CodingKeys: String, CodingKey {
        case value = "deleted"
    }
}
