//
//  BlockForwardTests.swift
//  Swift PackageTests
//
//  Created by Thanh-Nhon Nguyen on 08/11/2021.
//

@testable import Swift_Package
import XCTest

final class BlockForwardTests: XCTestCase {
    func testDecodable1() throws {
        let sut = try JSONDecoder().decode(BlockForward.self, from: MockedData.blockForward1)
        XCTAssertFalse(sut.value)
    }

    func testDecodable2() throws {
        let sut = try JSONDecoder().decode(BlockForward.self, from: MockedData.blockForward2)
        XCTAssertTrue(sut.value)
    }
}
