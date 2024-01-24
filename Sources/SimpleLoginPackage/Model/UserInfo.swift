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
    public let connectedProtonAddress: String?
    public let canCreateReverseAlias: Bool

    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case email = "email"
        case profilePictureUrl = "profile_picture_url"
        case isPremium = "is_premium"
        case inTrial = "in_trial"
        case maxAliasFreePlan = "max_alias_free_plan"
        case connectedProtonAddress = "connected_proton_address"
        case canCreateReverseAlias = "can_create_reverse_alias"
    }

    public init(name: String,
                email: String,
                profilePictureUrl: String?,
                isPremium: Bool,
                inTrial: Bool,
                maxAliasFreePlan: Int,
                connectedProtonAddress: String?,
                canCreateReverseAlias: Bool) {
        self.name = name
        self.email = email
        self.profilePictureUrl = profilePictureUrl
        self.isPremium = isPremium
        self.inTrial = inTrial
        self.maxAliasFreePlan = maxAliasFreePlan
        self.connectedProtonAddress = connectedProtonAddress
        self.canCreateReverseAlias = canCreateReverseAlias
    }

    // Explicit init function because `canCreateReverseAlias` is added without versioning the endpoint
    // This is for backward compatibility with outdated BE versions
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.email = try container.decode(String.self, forKey: .email)
        self.profilePictureUrl = try container.decodeIfPresent(String.self, forKey: .profilePictureUrl)
        self.isPremium = try container.decode(Bool.self, forKey: .isPremium)
        self.inTrial = try container.decode(Bool.self, forKey: .inTrial)
        self.maxAliasFreePlan = try container.decode(Int.self, forKey: .maxAliasFreePlan)
        self.connectedProtonAddress = try container.decodeIfPresent(String.self, forKey: .connectedProtonAddress)
        self.canCreateReverseAlias = try container.decodeIfPresent(Bool.self, 
                                                                   forKey: .canCreateReverseAlias) ?? false
    }
}
