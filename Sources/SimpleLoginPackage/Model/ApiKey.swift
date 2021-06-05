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
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.value = try container.decode(String.self)
    }
}
