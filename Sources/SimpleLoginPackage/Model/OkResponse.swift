//
//  OkResponse.swift
//  Swift Package
//
//  Created by Thanh-Nhon Nguyen on 27/08/2021.
//

import Foundation

/// Hold response from server in cases like update alias's mailboxes
public struct OkResponse: Decodable {
    public let value: Bool

    private enum CodingKeys: String, CodingKey {
        case value = "ok"
    }
}
