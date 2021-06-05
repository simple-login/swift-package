//
//  SLClientError.swift
//  Swift PackageTests
//
//  Created by Thanh-Nhon Nguyen on 05/06/2021.
//

import Foundation

enum SLClientError: Error, CustomStringConvertible {
    case clientError(ErrorResponse)
    case invalidServerResponse
    case other(Error)
    case unknown(statusCode: Int)

    var description: String {
        switch self {
        case let .clientError(error):
            return error.message

        case .invalidServerResponse:
            return "Invalid server response"

        case let .other(error):
            return "\(error.localizedDescription)"

        case let .unknown(statusCode):
            return "Unknown error with status (\(statusCode)"
        }
    }
}
