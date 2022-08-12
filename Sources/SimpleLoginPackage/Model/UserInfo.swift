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
    public let maxAliasFreePlan: Int
    public let isConnectedWithProton: Bool

    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case email = "email"
        case profilePictureUrl = "profile_picture_url"
        case isPremium = "is_premium"
        case inTrial = "in_trial"
        case maxAliasFreePlan = "max_alias_free_plan"
        case isConnectedWithProton = "is_connected_with_proton"
    }

    public init(name: String,
                email: String,
                profilePictureUrl: String?,
                isPremium: Bool,
                inTrial: Bool,
                maxAliasFreePlan: Int,
                isConnectedWithProton: Bool) {
        self.name = name
        self.email = email
        self.profilePictureUrl = profilePictureUrl
        self.isPremium = isPremium
        self.inTrial = inTrial
        self.maxAliasFreePlan = maxAliasFreePlan
        self.isConnectedWithProton = isConnectedWithProton
    }
}
