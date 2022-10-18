//
//  ContactLite.swift
//  Swift Package
//
//  Created by Thanh-Nhon Nguyen on 06/10/2021.
//

import Foundation

public struct ContactLite: Decodable {
    public let email: String
    public let name: String?
    public let reverseAlias: String

    private enum CodingKeys: String, CodingKey {
        case email = "email"
        case name = "name"
        case reverseAlias = "reverse_alias"
    }
}

// For SwiftUI preview purpose
public extension ContactLite {
    static let spadkins = ContactLite(email: "spadkins@mac.com",
                                      name: "Spad Kins",
                                      reverseAlias: "reverse.spadkins@mac.com")
    static let louise = ContactLite(email: "louise@gmail.com",
                                    name: "Louise",
                                    reverseAlias: "reverse.louise@gmail.com")
    static let dmiller = ContactLite(email: "dmiller@live.com",
                                     name: "Don Miller",
                                     reverseAlias: "reverse.dmiller@live.com")
    static let pierce = ContactLite(email: "pierce@yahoo.ca",
                                    name: "Pierce",
                                    reverseAlias: "reverse.pierce@yahoo.ca")
}
