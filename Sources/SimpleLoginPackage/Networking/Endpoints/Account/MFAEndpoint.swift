//
//  MFAEndpoint.swift
//  Swift Package
//
//  Created by Nhon Proton on 17/10/2022.
//

import Foundation

// POST /api/auth/mfa
// https://github.com/simple-login/app/blob/master/docs/api.md#post-apiauthmfa
public struct MFAEndpoint: EndpointV2 {
    public typealias Body = MFARequest
    public typealias Response = ApiKey

    public var path: String
    public var method: HTTPMethod
    public var body: MFARequest?

    public init(request: MFARequest) {
        self.path = "/api/auth/mfa"
        self.method = .post
        self.body = request
    }
}

public struct MFARequest: Encodable {
    let token: String
    let key: String
    let device: String

    private enum CodingKeys: String, CodingKey {
        case token = "mfa_token"
        case key = "mfa_key"
        case device = "device"
    }

    public init(token: String, key: String, device: String) {
        self.token = token
        self.key = key
        self.device = device
    }
}
