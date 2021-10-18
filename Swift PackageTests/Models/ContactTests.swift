//
//  ContactTests.swift
//  Swift PackageTests
//
//  Created by Thanh-Nhon Nguyen on 18/10/2021.
//

@testable import Swift_Package
import XCTest

final class ContactTests: XCTestCase {
    func testDecodable1() throws {
        let sut = try JSONDecoder().decode(Contact.self, from: MockedData.contact1)
        XCTAssertEqual(sut.id, 1)
        XCTAssertEqual(sut.creationTimestamp, 1_582_284_900)
        XCTAssertNil(sut.lastEmailSentTimestamp)
        XCTAssertEqual(sut.reverseAlias,
                       "marketing at example.com <reply+bzvpazcdedcgcpztehxzgjgzmxskqa@sl.co>")
        XCTAssertEqual(sut.reverseAliasAddress, "reply+bzvpazcdedcgcpztehxzgjgzmxskqa@sl.co")
    }

    func testDecodable2() throws {
        let sut = try JSONDecoder().decode(Contact.self, from: MockedData.contact2)
        XCTAssertEqual(sut.id, 2)
        XCTAssertEqual(sut.creationTimestamp, 1_582_284_900)
        XCTAssertEqual(sut.lastEmailSentTimestamp, 1_582_284_900)
        XCTAssertEqual(sut.reverseAlias,
                       "newsletter at example.com <reply+bzvpazcdedcgcpztehxzgjgzmxskqa@sl.co>")
        XCTAssertEqual(sut.reverseAliasAddress, "reply+bzvpazcdedcgcpztehxzgjgzmxskqa@sl.co")
    }
}
