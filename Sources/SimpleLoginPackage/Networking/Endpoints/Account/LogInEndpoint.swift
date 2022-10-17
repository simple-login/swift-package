//
//  LogInEndpoint.swift
//  Swift Package
//
//  Created by Nhon Proton on 17/10/2022.
//

import Foundation

// POST /api/auth/login
// https://github.com/simple-login/app/blob/master/docs/api.md#post-apiauthlogin
public struct LogInEndpoint: EndpointV2 {
    public typealias Body = LogInRequest
    public typealias Response = UserLogin

    public var path: String
    public var method: HTTPMethod
    public var body: LogInRequest?

    public init(request: LogInRequest) {
        self.path = "/api/auth/login"
        self.method = .post
        self.body = request
    }
}

public struct LogInRequest: Encodable {
    let email: String
    let password: String
    let device: String

    public init(email: String, password: String, device: String) {
        self.email = email
        self.password = password
        self.device = device
    }
}
