//
//  MailboxTests.swift
//  Swift PackageTests
//
//  Created by Thanh-Nhon Nguyen on 18/10/2021.
//

@testable import Swift_Package
import XCTest

final class MailboxTests: XCTestCase {
    func testDecodable() throws {
        let sut = try JSONDecoder().decode(Mailbox.self, from: MockedData.mailbox)
        XCTAssertEqual(sut.id, 1)
        XCTAssertEqual(sut.email, "a@b.c")
        XCTAssertTrue(sut.default)
        XCTAssertEqual(sut.creationTimestamp, 1_590_918_512)
        XCTAssertEqual(sut.aliasCount, 10)
        XCTAssertTrue(sut.verified)
    }
}
