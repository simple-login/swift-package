//
//  RegisterEndpoint.swift
//  Swift Package
//
//  Created by Nhon Proton on 17/10/2022.
//

import Foundation

// POST /api/auth/register
// https://github.com/simple-login/app/blob/master/docs/api.md#post-apiauthregister

public struct RegisterEndpoint: EndpointV2 {
    public typealias Body = RegisterRequest
    public typealias Response = MessageResponse

    public var path: String
    public var method: HTTPMethod
    public var body: RegisterRequest?

    public init(request: RegisterRequest) {
        self.path = "/api/auth/register"
        self.method = .post
        self.body = request
    }
}

public struct RegisterRequest: Encodable {
    let email: String
    let password: String

    public init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
