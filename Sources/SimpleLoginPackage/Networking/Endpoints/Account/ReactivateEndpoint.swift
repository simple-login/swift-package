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

    public init(email: String) {
        self.path = "/api/auth/reactivate"
        self.method = .post
        self.body = .init(email: email)
    }
}

public struct ReactivateRequest: Encodable {
    let email: String
}
