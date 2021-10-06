//
//  UserInfo.swift
//  Swift Package
//
//  Created by Thanh-Nhon Nguyen on 05/06/2021.
//

import Foundation

public struct UserInfo: Decodable {
    public let name: String
    public let email: String
    public let profilePictureUrl: String?
    public let isPremium: Bool
    public let inTrial: Bool

    private enum Key: String, CodingKey {
        case name = "name"
        case email = "email"
        case profilePictureUrl = "profile_picture_url"
        case isPremium = "is_premium"
        case inTrial = "in_trial"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.email = try container.decode(String.self, forKey: .email)
        self.profilePictureUrl = try container.decodeIfPresent(String.self, forKey: .profilePictureUrl)
        self.isPremium = try container.decode(Bool.self, forKey: .isPremium)
        self.inTrial = try container.decode(Bool.self, forKey: .inTrial)
    }
}
