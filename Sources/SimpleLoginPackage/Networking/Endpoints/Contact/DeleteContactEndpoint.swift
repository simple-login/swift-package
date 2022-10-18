//
//  DeleteContactEndpoint.swift
//  Swift Package
//
//  Created by Nhon Proton on 18/10/2022.
//

import Foundation

// DELETE /api/contacts/:contact_id
// https://github.com/simple-login/app/blob/master/docs/api.md#delete-apicontactscontact_id
public struct DeleteContactEndpoint: EndpointV2 {
    public typealias Body = EmptyBody
    public typealias Response = DeletedResponse

    public var path: String
    public var method: HTTPMethod
    public var apiKey: String?

    public init(apiKey: String, contactID: ContactID) {
        self.path = "/api/contacts/\(contactID)"
        self.method = .delete
        self.apiKey = apiKey
    }
}
