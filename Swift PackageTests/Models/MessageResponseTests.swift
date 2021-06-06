//
//  MessageResponseTests.swift
//  Swift PackageTests
//
//  Created by Thanh-Nhon Nguyen on 06/06/2021.
//

@testable import Swift_Package
import XCTest

final class MessageResponseTests: XCTestCase {
    func testDecodeSuccess() throws {
        let sut = try JSONDecoder().decode(MessageResponse.self, from: MockedData.message)
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut.message, "random message")
    }
}
