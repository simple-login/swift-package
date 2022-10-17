//
//  ReactivateEndpoint.swift
//  Swift Package
//
//  Created by Nhon Proton on 17/10/2022.
//

import Foundation

// POST /api/auth/reactivate
// https://github.com/simple-login/app/blob/master/docs/api.md#post-apiauthreactivate
public struct ReactivateEndpoint: EndpointV2 {
    public typealias Body = ReactivateRequest
    public typealias Response = MessageResponse

    public var path: String
    public var method: HTTPMethod
    public var body: ReactivateRequest?

    public init(request: ReactivateRequest) {
        self.path = "/api/auth/reactivate"
        self.method = .post
        self.body = request
    }
}

public struct ReactivateRequest: Encodable {
    let email: String

    public init(email: String) {
        self.email = email
    }
}
