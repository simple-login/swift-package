//
//  SLClientLoginTests.swift
//  Swift PackageTests
//
//  Created by Thanh-Nhon Nguyen on 04/06/2021.
//

import Combine
import Mocker
@testable import Swift_Package
import XCTest

// https://github.com/simple-login/app/blob/master/docs/api.md#account-endpoints
class AccountEndpointsTests: BaseEndpointsTests {}

// MARK: - POST /api/auth/login
// https://github.com/simple-login/app/blob/master/docs/api.md#post-apiauthlogin
extension AccountEndpointsTests {
    func testLoginSuccess() throws {
        // given
        let expectation = expectation(description: "userLogin object is returned")
        let loginRequest = sut.endpoint.login(email: .randomEmail(),
                                              password: .randomPassword(),
                                              device: .randomName())
        let loginUrl = try XCTUnwrap(loginRequest.url)

        // when
        Mock(url: loginUrl,
             dataType: .json,
             statusCode: 200,
             data: [.post: MockedData.userInfo1]).register()

        // then
        sut.login(email: .randomEmail(),
                  password: .randomPassword(),
                  device: .randomName())
            .sink { fini in
                switch fini {
                case .failure: XCTFail("Request should not fail")
                case .finished: break
                }
            } receiveValue: { userLogin in
                XCTAssertNotNil(userLogin)
                expectation.fulfill()
            }
            .store(in: &cancellableSet)

        waitForExpectations()
    }

    func testLoginFailureWithErrorResponse() throws {
        // given
        let expectation = expectation(description: "errorResponse object is returned")
        let loginRequest = sut.endpoint.login(email: .randomEmail(),
                                              password: .randomPassword(),
                                              device: .randomName())
        let loginUrl = try XCTUnwrap(loginRequest.url)
        let expectedError = try JSONDecoder().decode(ErrorResponse.self,
                                                     from: MockedData.errorResponse1)

        // when
        Mock(url: loginUrl,
             dataType: .json,
             statusCode: 400,
             data: [.post: MockedData.errorResponse1]).register()

        // then
        sut.login(email: .randomEmail(),
                  password: .randomPassword(),
                  device: .randomName())
            .sink { fini in
                switch fini {
                case let .failure(error):
                    XCTAssertEqual(error, SLClientError.clientError(expectedError))
                    expectation.fulfill()
                case .finished: break
                }
            } receiveValue: { _ in
                XCTFail("Request should not succeed")
            }
            .store(in: &cancellableSet)

        waitForExpectations()
    }

    func testLoginFailureWithUnknownErrorResponse() throws {
        // given
        let expectation = expectation(description: "errorResponse object is returned")
        let loginRequest = sut.endpoint.login(email: .randomEmail(),
                                              password: .randomPassword(),
                                              device: .randomName())
        let loginUrl = try XCTUnwrap(loginRequest.url)

        // when
        Mock(url: loginUrl,
             dataType: .json,
             statusCode: 406,
             data: [.post: MockedData.dummy]).register()

        // then
        sut.login(email: .randomEmail(),
                  password: .randomPassword(),
                  device: .randomName())
            .sink { fini in
                switch fini {
                case let .failure(error):
                    XCTAssertEqual(error, SLClientError.unknown(statusCode: 406))
                    expectation.fulfill()
                case .finished: break
                }
            } receiveValue: { _ in
                XCTFail("Request should not succeed")
            }
            .store(in: &cancellableSet)

        waitForExpectations()
    }

    func testLoginFailureWithServerError() throws {
        // given
        let expectation = expectation(description: "errorResponse object is returned")
        let loginRequest = sut.endpoint.login(email: .randomEmail(),
                                              password: .randomPassword(),
                                              device: .randomName())
        let loginUrl = try XCTUnwrap(loginRequest.url)

        // when
        Mock(url: loginUrl,
             dataType: .json,
             statusCode: 500,
             data: [.post: MockedData.dummy]).register()

        // then
        sut.login(email: .randomEmail(),
                  password: .randomPassword(),
                  device: .randomName())
            .sink { fini in
                switch fini {
                case let .failure(error):
                    XCTAssertEqual(error, SLClientError.unknown(statusCode: 500))
                    expectation.fulfill()
                case .finished: break
                }
            } receiveValue: { _ in
                XCTFail("Request should not succeed")
            }
            .store(in: &cancellableSet)

        waitForExpectations()
    }
}
