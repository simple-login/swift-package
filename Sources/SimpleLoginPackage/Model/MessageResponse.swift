//
//  MessageResponse.swift
//  Swift Package
//
//  Created by Thanh-Nhon Nguyen on 06/06/2021.
//

import Foundation

public struct MessageResponse {
    public let message: String
}

extension MessageResponse: Decodable {
    private enum Key: String, CodingKey {
        case message = "msg"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        self.message = try container.decode(String.self, forKey: .message)
    }
}
