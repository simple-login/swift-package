//
//  AliasActivity.swift
//  Swift Package
//
//  Created by Thanh-Nhon Nguyen on 06/10/2021.
//

import Foundation

public struct AliasActivity: Decodable {
    public enum Action: String, Decodable {
        case block = "block"
        case bounced = "bounced"
        case forward = "forward"
        case reply = "reply"
    }

    public let action: Action
    public let contact: AliasContact
    public let timestamp: TimeInterval
}
