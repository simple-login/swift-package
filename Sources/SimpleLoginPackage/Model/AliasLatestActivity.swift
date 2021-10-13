//
//  AliasActivity.swift
//  Swift Package
//
//  Created by Thanh-Nhon Nguyen on 06/10/2021.
//

import Foundation

public struct AliasLatestActivity: Decodable {
    public let action: ActivityAction
    public let contact: AliasContact
    public let timestamp: TimeInterval
}
