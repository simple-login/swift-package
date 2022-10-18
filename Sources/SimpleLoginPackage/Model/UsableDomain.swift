//
//  UsableDomain.swift
//  Swift Package
//
//  Created by Thanh-Nhon Nguyen on 20/10/2021.
//

import Foundation

public struct UsableDomain: Decodable {
    public let domain: String
    public let isCustom: Bool

    private enum CodingKeys: String, CodingKey {
        case domain = "domain"
        case isCustom = "is_custom"
    }
}
