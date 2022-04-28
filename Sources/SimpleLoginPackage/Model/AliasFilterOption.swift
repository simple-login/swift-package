//
//  AliasFilterOption.swift
//  Swift Package
//
//  Created by Nhon Nguyen on 27/04/2022.
//

import Foundation

public enum AliasFilterOption {
    case disabled
    case enabled
    case pinned

    public var queryItem: URLQueryItem {
        switch self {
        case .disabled: return .init(name: "disabled", value: nil)
        case .enabled: return .init(name: "enabled", value: nil)
        case .pinned: return .init(name: "pinned", value: nil)
        }
    }
}
