//
//  Suffix.swift
//  Swift Package
//
//  Created by Thanh-Nhon Nguyen on 15/09/2021.
//

import Foundation

public struct Suffix: Decodable {
    public let value: String
    public let signature: String
    public let isCustom: Bool
    public let isPremium: Bool

    private enum CodingKeys: String, CodingKey {
        case value = "suffix"
        case signature = "signed_suffix"
        case isCustom = "is_custom"
        case isPremium = "is_premium"
    }
}
