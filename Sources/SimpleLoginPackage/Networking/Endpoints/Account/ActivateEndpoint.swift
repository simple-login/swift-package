//
//  ActivateEndpoint.swift
//  Swift Package
//
//  Created by Nhon Proton on 17/10/2022.
//

import Foundation

// POST /api/auth/activate
// https://github.com/simple-login/app/blob/master/docs/api.md#post-apiauthactivate
public struct ActivateEndpoint: EndpointV2 {
    public typealias Body = ActivateRequest
    public typealias Response = MessageResponse

    public var path: String
    public var method: HTTPMethod
    public var body: ActivateRequest?

    public init(request: ActivateRequest) {
        self.path = "/api/auth/activate"
        self.method = .post
        self.body = request
    }
}

public struct ActivateRequest: Encodable {
    let email: String
    let code: String

    public init(email: String, code: String) {
        self.email = email
        self.code = code
    }
}
