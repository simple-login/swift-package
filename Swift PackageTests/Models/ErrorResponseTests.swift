//
//  ErrorResponseTests.swift
//  Swift PackageTests
//
//  Created by Thanh-Nhon Nguyen on 05/06/2021.
//

@testable import Swift_Package
import XCTest

final class ErrorResponseTests: XCTestCase {
    func testResponseWithoutCode() throws {
        let sut = try JSONDecoder().decode(ErrorResponse.self, from: MockedData.errorResponse1)
        XCTAssertEqual(sut.message, "random error message")
        XCTAssertNil(sut.code)
    }

    func testResponseWithCode() throws {
        let sut = try JSONDecoder().decode(ErrorResponse.self, from: MockedData.errorResponse2)
        XCTAssertEqual(sut.message, "random error message")
        XCTAssertEqual(sut.code, "some.error.code")
    }

    func testResponseWithCodeNull() throws {
        let sut = try JSONDecoder().decode(ErrorResponse.self, from: MockedData.errorResponse3)
        XCTAssertEqual(sut.message, "random error message")
        XCTAssertNil(sut.code)
    }
}
