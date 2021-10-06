//
//  AliasTests.swift
//  Swift PackageTests
//
//  Created by Thanh-Nhon Nguyen on 06/10/2021.
//

@testable import Swift_Package
import XCTest

final class AliasTests: XCTestCase {
    func testDecodable() throws {
        let sut = try JSONDecoder().decode(Alias.self, from: MockedData.alias)
        XCTAssertEqual(sut.creationTimestamp, 1_580_833_581)
        XCTAssertFalse(sut.pgpDisabled)
        XCTAssertEqual(sut.email, "john.doe.alias@example.com")
        XCTAssertTrue(sut.enabled)
        XCTAssertEqual(sut.id, 3_716)
        XCTAssertEqual(sut.latestActivity?.action, .forward)
        XCTAssertEqual(sut.latestActivity?.contact.email, "jane.doe@example.com")
        XCTAssertEqual(sut.latestActivity?.contact.name, "Jane Doe")
        XCTAssertEqual(sut.latestActivity?.contact.reverseAlias,
                       "Jane Doe <reply+uodvumu43fdfzidbzzqnt@simplelogin.co>")
        XCTAssertEqual(sut.latestActivity?.timestamp, 1_633_534_347)
        XCTAssertEqual(sut.mailboxes.count, 1)
        let firstMailbox = try XCTUnwrap(sut.mailboxes.first)
        XCTAssertEqual(firstMailbox.email, "john.doe@example.com")
        XCTAssertEqual(firstMailbox.id, 175)
        XCTAssertEqual(sut.name, "John Doe")
        XCTAssertEqual(sut.blockCount, 111)
        XCTAssertEqual(sut.forwardCount, 222)
        XCTAssertEqual(sut.replyCount, 333)
        XCTAssertNil(sut.note)
        XCTAssertTrue(sut.pinned)
        XCTAssertFalse(sut.pgpSupported)
    }
}
