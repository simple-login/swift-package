//
//  EnterSudoModeEndpoint.swift
//  Swift Package
//
//  Created by Nhon Proton on 18/10/2022.
//

import Foundation

// PATCH /api/sudo
// https://github.com/simple-login/app/blob/master/docs/api.md#patch-apisudo
public struct EnterSudoModeEndpoint: EndpointV2 {
    public typealias Body = EnterSudoModeRequest
    public typealias Response = OkResponse

    public var path: String
    public var method: HTTPMethod
    public var apiKey: String?
    public var body: EnterSudoModeRequest?

    public init(apiKey: String, password: String) {
        self.path = "/api/sudo"
        self.method = .patch
        self.apiKey = apiKey
        self.body = .init(password: password)
    }
}

public struct EnterSudoModeRequest: Encodable {
    let password: String
}
