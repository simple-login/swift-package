//
//  LogInEndpoint.swift
//  Swift Package
//
//  Created by Nhon Proton on 17/10/2022.
//

import Foundation

// POST /api/auth/login
// https://github.com/simple-login/app/blob/master/docs/api.md#post-apiauthlogin
public struct LogInEndpoint: Endpoint {
    public typealias Body = LogInRequest
    public typealias Response = UserLogin

    public var path: String
    public var method: HTTPMethod
    public var body: LogInRequest?

    public init(email: String, password: String, device: String) {
        self.path = "/api/auth/login"
        self.method = .post
        self.body = .init(email: email, password: password, device: device)
    }
}

public struct LogInRequest: Encodable {
    let email: String
    let password: String
    let device: String
}
