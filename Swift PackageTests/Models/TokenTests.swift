//
//  TokenTests.swift
//  Swift PackageTests
//
//  Created by Nhon Proton on 12/08/2022.
//

@testable import Swift_Package
import XCTest

final class TokenTests: XCTestCase {
    func testDecodable() throws {
        let token = try JSONDecoder().decode(Token.self, from: MockedData.token)
        XCTAssertEqual(token.value, "lorem ipsum")
    }
}
