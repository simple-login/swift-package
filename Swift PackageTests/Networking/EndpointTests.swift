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
}

// MARK: - Account
// https://github.com/simple-login/app/blob/master/docs/api.md#account-endpoints
extension EndpointTests {
    // MARK: - POST /api/auth/login
    // https://github.com/simple-login/app/blob/master/docs/api.md#post-apiauthlogin
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

    // MARK: - POST /api/auth/mfa
    // https://github.com/simple-login/app/blob/master/docs/api.md#post-apiauthmfa
    func testMfaEndpoint() throws {
        // given
        let token = String.randomPassword()
        let key = String.randomPassword()
        let device = String.randomName()
        let url = sut.baseUrl.appending(path: "/api/auth/mfa")

        // when
        let mfaRequest = try XCTUnwrap(sut.mfa(token: token, key: key, device: device))
        let mfaBody = try XCTUnwrap(mfaRequest.bodyDict)

        // then
        XCTAssertEqual(mfaRequest.url, url)
        XCTAssertEqual(mfaRequest.httpMethod, HttpMethod.post)
        assertContentTypeIsJson(mfaRequest)
        XCTAssertEqual(mfaBody["mfa_token"] as? String, token)
        XCTAssertEqual(mfaBody["mfa_key"] as? String, key)
        XCTAssertEqual(mfaBody["device"] as? String, device)
    }

    // MARK: - POST /api/auth/register
    // https://github.com/simple-login/app/blob/master/docs/api.md#post-apiauthregister
    func testRegisterEndpoint() throws {
        // given
        let email = String.randomEmail()
        let password = String.randomPassword()
        let url = sut.baseUrl.appending(path: "/api/auth/register")

        // when
        let registerRequest = try XCTUnwrap(sut.register(email: email, password: password))
        let registerBody = try XCTUnwrap(registerRequest.bodyDict)

        // then
        XCTAssertEqual(registerRequest.url, url)
        XCTAssertEqual(registerRequest.httpMethod, HttpMethod.post)
        assertContentTypeIsJson(registerRequest)
        XCTAssertEqual(registerBody["email"] as? String, email)
        XCTAssertEqual(registerBody["password"] as? String, password)
    }

    // MARK: - POST /api/auth/activate
    // https://github.com/simple-login/app/blob/master/docs/api.md#post-apiauthactivate
    func testActivateEndpoint() throws {
        // given
        let email = String.randomEmail()
        let code = String.randomName()
        let url = sut.baseUrl.appending(path: "/api/auth/activate")

        // when
        let activateRequest = try XCTUnwrap(sut.activate(email: email, code: code))
        let activateBody = try XCTUnwrap(activateRequest.bodyDict)

        // then
        XCTAssertEqual(activateRequest.url, url)
        XCTAssertEqual(activateRequest.httpMethod, HttpMethod.post)
        assertContentTypeIsJson(activateRequest)
        XCTAssertEqual(activateBody["email"] as? String, email)
        XCTAssertEqual(activateBody["code"] as? String, code)
    }
}
