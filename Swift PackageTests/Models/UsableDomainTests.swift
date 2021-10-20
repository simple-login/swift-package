//
//  UsableDomainTests.swift
//  Swift PackageTests
//
//  Created by Thanh-Nhon Nguyen on 20/10/2021.
//

@testable import Swift_Package
import XCTest

final class UsableDomainTests: XCTestCase {
    func testDecodable() throws {
        let sut = try JSONDecoder().decode(UsableDomain.self, from: MockedData.usableDomain)
        XCTAssertEqual(sut.domain, "d1.test")
        XCTAssertTrue(sut.isCustom)
    }
}
