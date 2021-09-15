//
//  AliasOptionsTests.swift
//  Swift PackageTests
//
//  Created by Thanh-Nhon Nguyen on 15/09/2021.
//

@testable import Swift_Package
import XCTest

final class AliasOptionsTests: XCTestCase {
    func testAliasOptions() throws {
        let sut = try JSONDecoder().decode(AliasOptions.self, from: MockedData.aliasOptions)
        XCTAssertTrue(sut.canCreate)
        XCTAssertEqual(sut.prefixSuggestion, "test")
        XCTAssertEqual(sut.suffixes.count, 3)
    }
}
