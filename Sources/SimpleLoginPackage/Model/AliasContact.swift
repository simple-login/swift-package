//
//  AliasContact.swift
//  Swift Package
//
//  Created by Thanh-Nhon Nguyen on 06/10/2021.
//

import Foundation

public struct AliasContact {
    public let email: String
    public let name: String?
    public let reverseAlias: String
}

extension AliasContact: Decodable {
    private enum Key: String, CodingKey {
        case email = "email"
        case name = "name"
        case reverseAlias = "reverse_alias"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        self.email = try container.decode(String.self, forKey: .email)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.reverseAlias = try container.decode(String.self, forKey: .reverseAlias)
    }
}

// For SwiftUI preview purpose
public extension AliasContact {
    static let spadkins = AliasContact(email: "spadkins@mac.com",
                                       name: "Spad Kins",
                                       reverseAlias: "reverse.spadkins@mac.com")
    static let louise = AliasContact(email: "louise@gmail.com",
                                     name: "Louise",
                                     reverseAlias: "reverse.louise@gmail.com")
    static let dmiller = AliasContact(email: "dmiller@live.com",
                                      name: "Don Miller",
                                      reverseAlias: "reverse.dmiller@live.com")
    static let pierce = AliasContact(email: "pierce@yahoo.ca",
                                     name: "Pierce",
                                     reverseAlias: "reverse.pierce@yahoo.ca")
}
