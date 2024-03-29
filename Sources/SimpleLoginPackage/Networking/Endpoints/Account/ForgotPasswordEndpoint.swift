//
//  ForgotPasswordEndpoint.swift
//  Swift Package
//
//  Created by Nhon Proton on 17/10/2022.
//

import Foundation

// POST /api/auth/forgot_password
// https://github.com/simple-login/app/blob/master/docs/api.md#post-apiauthforgot_password
public struct ForgotPasswordEndpoint: Endpoint {
    public typealias Body = ForgotPasswordRequest
    public typealias Response = OkResponse

    public var path: String
    public var method: HTTPMethod
    public var body: ForgotPasswordRequest?

    public init(email: String) {
        self.path = "/api/auth/forgot_password"
        self.method = .post
        self.body = .init(email: email)
    }
}

public struct ForgotPasswordRequest: Encodable {
    let email: String
}
