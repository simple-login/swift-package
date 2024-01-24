//
//  UserInfoTests.swift
//  Swift PackageTests
//
//  Created by Nhon Proton on 12/08/2022.
//

@testable import Swift_Package
import XCTest

final class UserInfoTests: XCTestCase {
    func testDecodable() throws {
        let userInfo1 = try JSONDecoder().decode(UserInfo.self, from: MockedData.userInfo1)
        XCTAssertEqual(userInfo1.name, "John Doe")
        XCTAssertFalse(userInfo1.isPremium)
        XCTAssertEqual(userInfo1.email, "john@doe.com")
        XCTAssertTrue(userInfo1.inTrial)
        XCTAssertNil(userInfo1.profilePictureUrl)
        XCTAssertEqual(userInfo1.maxAliasFreePlan, 12)
        XCTAssertNil(userInfo1.connectedProtonAddress)
        XCTAssertFalse(userInfo1.canCreateReverseAlias)

        let userInfo2 = try JSONDecoder().decode(UserInfo.self, from: MockedData.userInfo2)
        XCTAssertEqual(userInfo2.name, "Jane Doe")
        XCTAssertTrue(userInfo2.isPremium)
        XCTAssertEqual(userInfo2.email, "jane@doe.com")
        XCTAssertFalse(userInfo2.inTrial)
        XCTAssertEqual(userInfo2.profilePictureUrl, "https://profile.png")
        XCTAssertEqual(userInfo2.maxAliasFreePlan, 7)
        XCTAssertEqual(userInfo2.connectedProtonAddress, "jane.doe@proton.me")
        XCTAssertTrue(userInfo2.canCreateReverseAlias)
    }
}
