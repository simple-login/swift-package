//
//  UserSettings.swift
//  Swift PackageTests
//
//  Created by Thanh-Nhon Nguyen on 20/10/2021.
//

@testable import Swift_Package
import XCTest

final class UserSettingsTests: XCTestCase {
    func testDecodable() throws {
        let sut = try JSONDecoder().decode(UserSettings.self, from: MockedData.userSettings)
        XCTAssertEqual(sut.randomMode, .word)
        XCTAssertTrue(sut.notification)
        XCTAssertEqual(sut.randomAliasDefaultDomain, "sl.local")
        XCTAssertEqual(sut.senderFormat, .at)
    }
}
