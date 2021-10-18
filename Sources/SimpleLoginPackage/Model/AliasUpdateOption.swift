//
//  AliasUpdateOptions.swift
//  Swift Package
//
//  Created by Thanh-Nhon Nguyen on 18/10/2021.
//

import Foundation

public enum AliasUpdateOption {
    case note(String?)
    case name(String?)
    case mailboxIds([Int])
    case disablePgp(Bool)
    case pinned(Bool)

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
