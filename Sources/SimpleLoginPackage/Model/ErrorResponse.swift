//
//  ErrorResponse.swift
//  Swift PackageTests
//
//  Created by Thanh-Nhon Nguyen on 05/06/2021.
//

import Foundation

public struct ErrorResponse {
    public let message: String
    public let code: String?
    public var statusCode = -1
}

extension ErrorResponse: Decodable {
    private enum Key: String, CodingKey {
        case message = "error"
        case code = "error_code"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        self.message = try container.decode(String.self, forKey: .message)
        self.code = try container.decodeIfPresent(String.self, forKey: .code)
    }
}
