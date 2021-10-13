//
//  ActivityAction.swift
//  Swift Package
//
//  Created by Thanh-Nhon Nguyen on 13/10/2021.
//

import Foundation

public enum ActivityAction: String, Decodable {
    case block = "block"
    case bounced = "bounced"
    case forward = "forward"
    case reply = "reply"
}
