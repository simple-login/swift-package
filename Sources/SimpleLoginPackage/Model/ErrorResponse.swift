//
//  ErrorResponse.swift
//  Swift PackageTests
//
//  Created by Thanh-Nhon Nguyen on 05/06/2021.
//

import Foundation

public struct ErrorResponse: Decodable {
    public let message: String
    public let code: String?
    public var statusCode = -1

    private enum CodingKeys: String, CodingKey {
        case message = "error"
        case code = "error_code"
    }
}
