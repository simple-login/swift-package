//
//  ActivateEndpoint.swift
//  Swift Package
//
//  Created by Nhon Proton on 17/10/2022.
//

import Foundation

// POST /api/auth/activate
// https://github.com/simple-login/app/blob/master/docs/api.md#post-apiauthactivate
public struct ActivateEndpoint: Endpoint {
    public typealias Body = ActivateRequest
    public typealias Response = MessageResponse

    public var path: String
    public var method: HTTPMethod
    public var body: ActivateRequest?

    public init(email: String, code: String) {
        self.path = "/api/auth/activate"
        self.method = .post
        self.body = .init(email: email, code: code)
    }
}

public struct ActivateRequest: Encodable {
    let email: String
    let code: String
}
