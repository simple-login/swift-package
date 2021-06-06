//
//  SLClientTests.swift
//  Swift PackageTests
//
//  Created by Thanh-Nhon Nguyen on 05/06/2021.
//

import Combine
import Mocker
@testable import Swift_Package
import XCTest

class BaseEndpointsTests: XCTestCase {
    var sut: SLClient!
    var cancellableSet: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        let sessionConfig = URLSessionConfiguration.ephemeral
        sessionConfig.protocolClasses = [MockingURLProtocol.self]
        sut = SLClient(session: URLSession(configuration: sessionConfig))
    }

    func waitForExpectations() {
        waitForExpectations(timeout: 5.0, handler: nil)
    }
}
