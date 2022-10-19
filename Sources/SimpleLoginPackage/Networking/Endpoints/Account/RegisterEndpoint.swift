//
//  RegisterEndpoint.swift
//  Swift Package
//
//  Created by Nhon Proton on 17/10/2022.
//

import Foundation

// POST /api/auth/register
// https://github.com/simple-login/app/blob/master/docs/api.md#post-apiauthregister
public struct RegisterEndpoint: Endpoint {
    public typealias Body = RegisterRequest
    public typealias Response = MessageResponse

    public var path: String
    public var method: HTTPMethod
    public var body: RegisterRequest?

    public init(email: String, password: String) {
        self.path = "/api/auth/register"
        self.method = .post
        self.body = .init(email: email, password: password)
    }
}

public struct RegisterRequest: Encodable {
    let email: String
    let password: String
}
