//
//  MessageResponse.swift
//  Swift Package
//
//  Created by Thanh-Nhon Nguyen on 06/06/2021.
//

import Foundation

public struct MessageResponse: Decodable {
    public let message: String

    private enum CodingKeys: String, CodingKey {
        case message = "msg"
    }
}
