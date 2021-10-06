//
//  UserLogin.swift
//  Swift Package
//
//  Created by Thanh-Nhon Nguyen on 05/06/2021.
//

import Foundation

public struct UserLogin {
    public let apiKey: ApiKey?
    public let email: String
    public let isMfaEnabled: Bool
    public let mfaKey: String?
    public let name: String
}

extension UserLogin: Decodable {
    private enum Key: String, CodingKey {
        case apiKey = "api_key"
        case email = "email"
        case isMfaEnabled = "mfa_enabled"
        case mfaKey = "mfa_key"
        case name = "name"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        if let apiKeyValue = try container.decodeIfPresent(String.self, forKey: .apiKey) {
            self.apiKey = ApiKey(value: apiKeyValue)
        } else {
            self.apiKey = nil
        }
        self.email = try container.decode(String.self, forKey: .email)
        self.isMfaEnabled = try container.decode(Bool.self, forKey: .isMfaEnabled)
        self.mfaKey = try container.decodeIfPresent(String.self, forKey: .mfaKey)
        self.name = try container.decode(String.self, forKey: .name)
    }
}
