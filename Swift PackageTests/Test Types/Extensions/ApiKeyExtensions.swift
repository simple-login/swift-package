//
//  ApiKeyExtensions.swift
//  Swift PackageTests
//
//  Created by Thanh-Nhon Nguyen on 05/06/2021.
//

@testable import Swift_Package

extension ApiKey: Equatable {
    public static func == (lhs: ApiKey, rhs: ApiKey) -> Bool {
        lhs.value == rhs.value
    }
}
