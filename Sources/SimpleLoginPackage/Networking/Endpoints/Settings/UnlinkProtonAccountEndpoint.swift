//
//  UnlinkProtonAccountEndpoint.swift
//  Swift Package
//
//  Created by Nhon Proton on 18/10/2022.
//

import Foundation

// DELETE /api/setting/unlink_proton_account
public struct UnlinkProtonAccountEndpoint: Endpoint {
    public typealias Body = EmptyBody
    public typealias Response = OkResponse

    public var path: String
    public var method: HTTPMethod
    public var apiKey: String?

    public init(apiKey: String) {
        self.path = "/api/setting/unlink_proton_account"
        self.method = .delete
        self.apiKey = apiKey
    }
}
