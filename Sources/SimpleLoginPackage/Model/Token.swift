//
//  Token.swift
//  Swift PackageTests
//
//  Created by Nhon Proton on 12/08/2022.
//

import Foundation

public struct Token: Decodable {
    public let value: String

    enum CodingKeys: String, CodingKey {
        case value = "token"
    }
}
