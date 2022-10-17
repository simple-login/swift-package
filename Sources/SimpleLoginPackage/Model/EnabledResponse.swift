//
//  EnabledResponse.swift
//  Swift Package
//
//  Created by Thanh-Nhon Nguyen on 13/10/2021.
//

import Foundation

/// Hold response from server when enable/disable an alias
public struct EnabledResponse: Decodable {
    public let value: Bool

    private enum CodingKeys: String, CodingKey {
        case value = "enabled"
    }
}
