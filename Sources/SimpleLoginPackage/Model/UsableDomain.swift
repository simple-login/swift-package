//
//  UsableDomain.swift
//  Swift Package
//
//  Created by Thanh-Nhon Nguyen on 20/10/2021.
//

import Foundation

public struct UsableDomain {
    public let domain: String
    public let isCustom: Bool
}

extension UsableDomain: Decodable {
    private enum Key: String, CodingKey {
        case domain = "domain"
        case isCustom = "is_custom"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        self.domain = try container.decode(String.self, forKey: .domain)
        self.isCustom = try container.decode(Bool.self, forKey: .isCustom)
    }
}
