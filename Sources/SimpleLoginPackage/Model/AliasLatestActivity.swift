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

public extension AliasLatestActivity {
    var date: Date {
        Date(timeIntervalSince1970: timestamp)
    }

    var relativeDateString: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.dateTimeStyle = .named
        return formatter.string(for: date) ?? ""
    }
}

// For SwiftUI preview purpose
public extension AliasLatestActivity {
    static let block = AliasLatestActivity(action: .block,
                                           contact: .dmiller,
                                           timestamp: 1_635_277_627)
    static let bounced = AliasLatestActivity(action: .bounced,
                                             contact: .louise,
                                             timestamp: 1_635_277_668)
    static let forward = AliasLatestActivity(action: .forward,
                                             contact: .spadkins,
                                             timestamp: 1_635_277_701)
    static let reply = AliasLatestActivity(action: .reply,
                                           contact: .pierce,
                                           timestamp: 1_635_277_741)
}
