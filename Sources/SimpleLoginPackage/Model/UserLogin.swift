//
//  UserLogin.swift
//  Swift Package
//
//  Created by Thanh-Nhon Nguyen on 05/06/2021.
//

import Foundation

public struct UserLogin {
    public let apiKey: String?
    public let email: String
    public let isMfaEnabled: Bool
    public let mfaKey: String?
    public let name: String
}

extension UserLogin: Decodable {
    private enum CodingKeys: String, CodingKey {
        case apiKey = "api_key"
        case email = "email"
        case isMfaEnabled = "mfa_enabled"
        case mfaKey = "mfa_key"
        case name = "name"
    }
}
