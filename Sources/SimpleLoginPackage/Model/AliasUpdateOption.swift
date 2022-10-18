//
//  AliasUpdateOptions.swift
//  Swift Package
//
//  Created by Thanh-Nhon Nguyen on 18/10/2021.
//

import Foundation

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

    public var requestBody: [String: Any?] {
        switch self {
        case .note(let note): return ["note": note]
        case .name(let name): return ["name": name]
        case .mailboxIds(let ids): return ["mailbox_ids": ids]
        case .disablePgp(let disabled): return ["disable_pgp": disabled]
        case .pinned(let pinned): return ["pinned": pinned]
        }
    }
}
