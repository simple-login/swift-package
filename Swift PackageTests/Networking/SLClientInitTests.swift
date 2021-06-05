//
//  SLClientInitTests.swift
//  Swift PackageTests
//
//  Created by Thanh-Nhon Nguyen on 05/06/2021.
//

@testable import Swift_Package
import XCTest

final class SLClientInitTests: XCTestCase {
    func testInitFailWithBadUrlString() {
        XCTAssertNil(SLClient(session: .shared, baseUrlString: ""))
    }
}
