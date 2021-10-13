//
//  AliasActivityTests.swift
//  Swift PackageTests
//
//  Created by Thanh-Nhon Nguyen on 13/10/2021.
//

@testable import Swift_Package
import XCTest

final class AliasActivityTests: XCTestCase {
    func testDecodable() throws {
        let sut = try JSONDecoder().decode(AliasActivity.self, from: MockedData.aliasActivity)
        XCTAssertEqual(sut.action, .reply)
        XCTAssertEqual(sut.timestamp, 1_580_903_760)
        XCTAssertEqual(sut.from, "yes_meo_chat@sl.local")
        XCTAssertEqual(sut.to, "marketing@example.com")
        XCTAssertEqual(sut.reverseAlias, "\"marketing at example.com\" <reply@a.b>")
        XCTAssertEqual(sut.reverseAliasAddress, "reply@a.b")
    }
}
