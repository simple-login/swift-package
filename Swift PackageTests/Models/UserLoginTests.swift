//
//  UserLoginTests.swift
//  Swift PackageTests
//
//  Created by Thanh-Nhon Nguyen on 05/06/2021.
//

@testable import Swift_Package
import XCTest

final class UserLoginTests: XCTestCase {
    func testUserLoginWithApiKey() throws {
        let sut = try JSONDecoder().decode(UserLogin.self, from: MockedData.userLogin1)
        XCTAssertEqual(sut.apiKey, "eacfxawdwmymniociltiabnodmibtbnc")
        XCTAssertEqual(sut.email, "john.doe@example.com")
        XCTAssertFalse(sut.isMfaEnabled)
        XCTAssertNil(sut.mfaKey)
        XCTAssertEqual(sut.name, "John Doe")
    }

    func testUserLoginWithoutApiKey() throws {
        let sut = try JSONDecoder().decode(UserLogin.self, from: MockedData.userLogin2)
        XCTAssertNil(sut.apiKey)
        XCTAssertEqual(sut.email, "jane.doe@example.com")
        XCTAssertTrue(sut.isMfaEnabled)
        XCTAssertEqual(sut.mfaKey, "dnkjhq73n1i945umxux21oe38yn")
        XCTAssertEqual(sut.name, "Jane Doe")
    }
}
