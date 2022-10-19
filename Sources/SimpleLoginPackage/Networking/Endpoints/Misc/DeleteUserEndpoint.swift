//
//  DeleteUserEndpoint.swift
//  Swift Package
//
//  Created by Nhon Proton on 18/10/2022.
//

import Foundation

// DELETE /api/user
// https://github.com/simple-login/app/blob/master/docs/api.md#delete-apiuser
public struct DeleteUserEndpoint: Endpoint {
    public typealias Body = EmptyBody
    public typealias Response = OkResponse

    public var path: String
    public var method: HTTPMethod
    public var apiKey: String?

    public init(apiKey: String) {
        self.path = "/api/user"
        self.method = .delete
        self.apiKey = apiKey
    }
}
