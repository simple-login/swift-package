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

    func assertApiKeyAttached(_ request: URLRequest, apiKey: ApiKey) {
        XCTAssertEqual(request.allHTTPHeaderFields?["Authentication"], apiKey.value)
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

    // MARK: - POST /api/auth/reactivate
    // https://github.com/simple-login/app/blob/master/docs/api.md#post-apiauthreactivate
    func testReactivateEndpoint() throws {
        // given
        let email = String.randomEmail()
        let url = sut.baseUrl.appending(path: "/api/auth/reactivate")

        // when
        let reactivateRequest = try XCTUnwrap(sut.reactivate(email: email))
        let reactivateBody = try XCTUnwrap(reactivateRequest.bodyDict)

        // then
        XCTAssertEqual(reactivateRequest.url, url)
        XCTAssertEqual(reactivateRequest.httpMethod, HttpMethod.post)
        assertContentTypeIsJson(reactivateRequest)
        XCTAssertEqual(reactivateBody["email"] as? String, email)
    }

    // MARK: - POST /api/auth/forgot_password
    // https://github.com/simple-login/app/blob/master/docs/api.md#post-apiauthforgot_password
    func testForgotPasswordEndpoint() throws {
        // given
        let email = String.randomEmail()
        let url = sut.baseUrl.appending(path: "/api/auth/forgot_password")

        // when
        let forgotPasswordRequest = try XCTUnwrap(sut.forgotPassword(email: email))
        let forgotPasswordBody = try XCTUnwrap(forgotPasswordRequest.bodyDict)

        // then
        XCTAssertEqual(forgotPasswordRequest.url, url)
        XCTAssertEqual(forgotPasswordRequest.httpMethod, HttpMethod.post)
        assertContentTypeIsJson(forgotPasswordRequest)
        XCTAssertEqual(forgotPasswordBody["email"] as? String, email)
    }

    // MARK: - GET /api/user_info
    // https://github.com/simple-login/app/blob/master/docs/api.md#get-apiuser_info
    func testGetUserInfoEndpoint() throws {
        // given
        let apiKey = ApiKey.random()
        let url = sut.baseUrl.appending(path: "/api/user_info")

        // when
        let getUserInfoRequest = try XCTUnwrap(sut.getUserInfo(apiKey: apiKey))

        // then
        XCTAssertEqual(getUserInfoRequest.url, url)
        XCTAssertEqual(getUserInfoRequest.httpMethod, HttpMethod.get)
        assertApiKeyAttached(getUserInfoRequest, apiKey: apiKey)
    }

    // MARK: - PATCH /api/user_info
    // https://github.com/simple-login/app/blob/master/docs/api.md#patch-apiuser_info
    func testUpdateProfilePictureEndpoint() throws {
        // given
        let apiKey = ApiKey.random()
        let profilePicture = String.randomNullableName()
        let url = sut.baseUrl.appending(path: "/api/user_info")

        // when
        let updateProfilePictureRequest =
            try XCTUnwrap(sut.updateProfilePicture(apiKey: apiKey,
                                                   profilePicture: profilePicture))
        let updateProfilePictureBody = try XCTUnwrap(updateProfilePictureRequest.bodyDict)

        // then
        XCTAssertEqual(updateProfilePictureRequest.url, url)
        XCTAssertEqual(updateProfilePictureRequest.httpMethod, HttpMethod.patch)
        assertContentTypeIsJson(updateProfilePictureRequest)
        assertApiKeyAttached(updateProfilePictureRequest, apiKey: apiKey)
        XCTAssertEqual(updateProfilePictureBody["profile_picture"] as? String, profilePicture)
    }

    func testUpdateProfileNameEndpoint() throws {
        // given
        let apiKey = ApiKey.random()
        let name = String.randomNullableName()
        let url = sut.baseUrl.appending(path: "/api/user_info")

        // when
        let updateProfileNameRequest = try XCTUnwrap(sut.updateProfileName(apiKey: apiKey,
                                                                           name: name))
        let updateProfileNameBody = try XCTUnwrap(updateProfileNameRequest.bodyDict)

        // then
        XCTAssertEqual(updateProfileNameRequest.url, url)
        XCTAssertEqual(updateProfileNameRequest.httpMethod, HttpMethod.patch)
        assertContentTypeIsJson(updateProfileNameRequest)
        assertApiKeyAttached(updateProfileNameRequest, apiKey: apiKey)
        XCTAssertEqual(updateProfileNameBody["name"] as? String, name)
    }
}

// MARK: - Alias
extension EndpointTests {
    // MARK: - GET /api/v5/alias/options
    // https://github.com/simple-login/app/blob/master/docs/api.md#get-apiv5aliasoptions
    func testGetAliasOptionsWithHostnameEndpoint() throws {
        // given
        let apiKey = ApiKey.random()
        let hostname = String.randomName()
        let url = sut.baseUrl.appending(path: "/api/v5/alias/options",
                                        queryItems: [.init(name: "hostname", value: hostname)])

        // when
        let getAliasOptionsRequest = try XCTUnwrap(sut.getAliasOptions(apiKey: apiKey,
                                                                       hostname: hostname))

        // then
        XCTAssertEqual(getAliasOptionsRequest.url, url)
        XCTAssertEqual(getAliasOptionsRequest.httpMethod, HttpMethod.get)
        assertApiKeyAttached(getAliasOptionsRequest, apiKey: apiKey)
    }

    func testGetAliasOptionsWithoutHostnameEndpoint() throws {
        // given
        let apiKey = ApiKey.random()
        let url = sut.baseUrl.appending(path: "/api/v5/alias/options")

        // when
        let getAliasOptionsRequest = try XCTUnwrap(sut.getAliasOptions(apiKey: apiKey,
                                                                       hostname: nil))

        // then
        XCTAssertEqual(getAliasOptionsRequest.url, url)
        XCTAssertEqual(getAliasOptionsRequest.httpMethod, HttpMethod.get)
        assertApiKeyAttached(getAliasOptionsRequest, apiKey: apiKey)
    }
}
