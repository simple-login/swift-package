//
//  ApiKey.swift
//  Swift Package
//
//  Created by Thanh-Nhon Nguyen on 04/06/2021.
//

import Foundation

public struct ApiKey: Decodable {
    public let value: String

    private enum CodingKeys: String, CodingKey {
        case value = "api_key"
    }

    public init(value: String) {
        self.value = value
    }
}
