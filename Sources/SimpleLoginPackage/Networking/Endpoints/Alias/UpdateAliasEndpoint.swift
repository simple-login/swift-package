//
//  UpdateAliasEndpoint.swift
//  Swift Package
//
//  Created by Nhon Proton on 18/10/2022.
//

import Foundation

// PATCH /api/aliases/:alias_id
// https://github.com/simple-login/app/blob/master/docs/api.md#patch-apialiasesalias_id
public struct UpdateAliasEndpoint: Endpoint {
    public typealias Body = AliasUpdateOption
    public typealias Response = OkResponse

    public var path: String
    public var method: HTTPMethod
    public var apiKey: String?
    public var body: AliasUpdateOption?

    public init(apiKey: String, aliasID: AliasID, option: AliasUpdateOption) {
        self.path = "/api/aliases/\(aliasID)"
        self.method = .patch
        self.apiKey = apiKey
        self.body = option
    }
}

public enum AliasUpdateOption: Encodable {
    case note(String?)
    case name(String?)
    case mailboxIds([Int])
    case disablePgp(Bool)
    case pinned(Bool)

    private enum CodingKeys: String, CodingKey {
        case note = "note"
        case name = "name"
        case mailboxIds = "mailbox_ids"
        case disablePgp = "disable_pgp"
        case pinned = "pinned"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .note(let note):
            try container.encode(note, forKey: .note)
        case .name(let name):
            try container.encode(name, forKey: .name)
        case .mailboxIds(let ids):
            try container.encode(ids, forKey: .mailboxIds)
        case .disablePgp(let disabled):
            try container.encode(disabled, forKey: .disablePgp)
        case .pinned(let pinned):
            try container.encode(pinned, forKey: .pinned)
        }
    }
}
