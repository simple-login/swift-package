//
//  ErrorResponseExtensions.swift
//  Swift PackageTests
//
//  Created by Thanh-Nhon Nguyen on 05/06/2021.
//

@testable import Swift_Package

extension ErrorResponse: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.message == rhs.message && lhs.code == rhs.code
    }
}
