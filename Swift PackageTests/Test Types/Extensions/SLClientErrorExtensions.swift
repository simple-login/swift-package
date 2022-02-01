//
//  SLClientErrorExtensions.swift
//  Swift PackageTests
//
//  Created by Thanh-Nhon Nguyen on 05/06/2021.
//

@testable import Swift_Package

extension SLClientError: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case let (.clientError(error1), .clientError(error2)):
            return error1 == error2

        case (.invalidServerResponse, .invalidServerResponse):
            return true

        case let (.unknown(statusCode1), .unknown(statusCode2)):
            return statusCode1 == statusCode2

        default:
            return false
        }
    }
}
