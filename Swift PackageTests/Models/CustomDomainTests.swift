//
//  CustomDomainTests.swift
//  Swift PackageTests
//
//  Created by Thanh-Nhon Nguyen on 18/10/2021.
//

@testable import Swift_Package
import XCTest

final class CustomDomainTests: XCTestCase {
    func testDecodable1() throws {
        let sut = try JSONDecoder().decode(CustomDomain.self, from: MockedData.customDomain1)
        XCTAssertEqual(sut.id, 78)
        XCTAssertEqual(sut.creationTimestamp, 1_988_412_168)
        XCTAssertEqual(sut.domainName, "test.org")
        XCTAssertEqual(sut.name, "custom domain name test")
        XCTAssertFalse(sut.verified)
        XCTAssertEqual(sut.aliasCount, 58)
        XCTAssertTrue(sut.randomPrefixGeneration)
        XCTAssertEqual(sut.mailboxes.count, 1)
        XCTAssertTrue(sut.catchAll)
    }

    func testDecodable2() throws {
        let sut = try JSONDecoder().decode(CustomDomain.self, from: MockedData.customDomain2)
        XCTAssertEqual(sut.id, 1)
        XCTAssertEqual(sut.creationTimestamp, 1_698_412_168)
        XCTAssertEqual(sut.domainName, "test1.org")
        XCTAssertNil(sut.name)
        XCTAssertTrue(sut.verified)
        XCTAssertEqual(sut.aliasCount, 0)
        XCTAssertFalse(sut.randomPrefixGeneration)
        XCTAssertEqual(sut.mailboxes.count, 1)
        XCTAssertFalse(sut.catchAll)
    }
}
