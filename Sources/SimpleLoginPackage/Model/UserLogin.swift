//
//  UserLogin.swift
//  Swift Package
//
//  Created by Thanh-Nhon Nguyen on 05/06/2021.
//

import Foundation

public struct UserLogin: Decodable {
    public let apiKey: ApiKey?
    public let email: String
    public let isMfaEnabled: Bool
    public let mfaKey: String?
    public let name: String

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        self.apiKey = try container.decodeIfPresent(ApiKey.self, forKey: .apiKey)
        self.email = try container.decode(String.self, forKey: .email)
        self.isMfaEnabled = try container.decode(Bool.self, forKey: .isMfaEnabled)
        self.mfaKey = try container.decodeIfPresent(String.self, forKey: .mfaKey)
        self.name = try container.decode(String.self, forKey: .name)
    }

    // swiftlint:disable:next type_name
    enum Key: String, CodingKey {
        case apiKey = "api_key"
        case email = "email"
        case isMfaEnabled = "mfa_enabled"
        case mfaKey = "mfa_key"
        case name = "name"
    }
}
