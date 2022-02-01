//
//  SLClientError.swift
//  Swift PackageTests
//
//  Created by Thanh-Nhon Nguyen on 05/06/2021.
//

import Foundation

public enum SLClientError: Error {
    case clientError(ErrorResponse)
    case invalidServerResponse
    case unknown(statusCode: Int)

    public var localizedDescription: String {
        switch self {
        case let .clientError(error):
            return error.message

        case .invalidServerResponse:
            return "Invalid server response"

        case let .unknown(statusCode):
            return "Unknown error with status (\(statusCode)"
        }
    }
}
