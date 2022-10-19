//
//  ToggleContactEndpoint.swift
//  Swift Package
//
//  Created by Nhon Proton on 18/10/2022.
//

import Foundation

// POST /api/contacts/:contact_id/toggle
// https://github.com/simple-login/app/blob/master/docs/api.md#post-apicontactscontact_idtoggle
public struct ToggleContactEndpoint: Endpoint {
    public typealias Body = EmptyBody
    public typealias Response = BlockForward

    public var path: String
    public var method: HTTPMethod
    public var apiKey: String?

    public init(apiKey: String, contactID: ContactID) {
        self.path = "/api/contacts/\(contactID)/toggle"
        self.method = .post
        self.apiKey = apiKey
    }
}
