//
//  AliasRandomOptions.swift
//  Swift PackageTests
//
//  Created by Thanh-Nhon Nguyen on 06/10/2021.
//

import Foundation

public struct AliasRandomOptions {
    let hostname: String?
    let mode: RandomMode
    let note: String?

    public init(mode: RandomMode, hostname: String? = nil, note: String? = nil) {
        self.hostname = hostname
        self.mode = mode
        self.note = note
    }

    public func requestBody() -> [String: Any?] {
        ["note": note]
    }

    public func queryItems() -> [URLQueryItem] {
        [.init(name: "hostname", value: hostname),
         .init(name: "mode", value: mode.rawValue)]
    }
}

public enum RandomMode: String, Decodable, CaseIterable {
    case uuid = "uuid"
    case word = "word"
}
