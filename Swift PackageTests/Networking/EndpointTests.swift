//
//  EndpointTests.swift
//  Swift PackageTests
//
//  Created by Thanh-Nhon Nguyen on 05/06/2021.
//

@testable import Swift_Package
import XCTest

final class EndpointTests: XCTestCase {
    var sut: Endpoint!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let randomBaseUrl = try XCTUnwrap(URL(string: .randomUrlString()))
        sut = Endpoint(baseUrl: randomBaseUrl)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func assertContentTypeIsJson(_ request: URLRequest) {
        XCTAssertEqual(request.allHTTPHeaderFields?["Content-Type"], "application/json")
    }

    func testLoginEndpoint() throws {
        // given
        let email = String.randomEmail()
        let password = String.randomPassword()
        let device = String.randomName()
        let url = sut.baseUrl.appending(path: "/api/auth/login")

        // when
        let loginRequest = try XCTUnwrap(sut.login(email: email, password: password, device: device))
        let loginBody = try XCTUnwrap(loginRequest.bodyDict)

        // then
        XCTAssertEqual(loginRequest.url, url)
        XCTAssertEqual(loginRequest.httpMethod, HttpMethod.post)
        assertContentTypeIsJson(loginRequest)
        XCTAssertEqual(loginBody["email"] as? String, email)
        XCTAssertEqual(loginBody["password"] as? String, password)
        XCTAssertEqual(loginBody["device"] as? String, device)
    }
}
