//
//  RandomAliasEndpoint.swift
//  Swift Package
//
//  Created by Nhon Proton on 17/10/2022.
//

import Foundation

// POST /api/alias/random/new
// https://github.com/simple-login/app/blob/master/docs/api.md#post-apialiasrandomnew
public struct RandomAliasEndpoint: EndpointV2 {
    public typealias Body = RandomAliasRequest
    public typealias Response = Alias

    public var path: String
    public var method: HTTPMethod
    public var apiKey: String?
    public var body: RandomAliasRequest?
    public var parameters: [String: String?]?

    public init(apiKey: String,
                request: RandomAliasRequest,
                mode: RandomMode,
                hostname: String?) {
        self.path = "/api/alias/random/new"
        self.method = .post
        self.apiKey = apiKey
        self.body = request
        self.parameters = ["mode": mode.rawValue,
                           "hostname": hostname]
    }
}

public struct RandomAliasRequest: Encodable {
    let note: String?

    public init(note: String? = nil) {
        self.note = note
    }
}

public enum RandomMode: String, Decodable, CaseIterable {
    case uuid = "uuid"
    case word = "word"
}
