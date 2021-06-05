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

class SLClientLoginTests: SLClientTests {
    func testLoginSuccess() throws {
        // given
        let expectation = expectation(description: "userLogin object is returned")
        let email = String.randomEmail()
        let password = String.randomPassword()
        let device = String.randomName()
        let loginRequestUrl = try XCTUnwrap(sut.endpoint.login(email: email,
                                                               password: password,
                                                               device: device).url)

        // when
        Mock(url: loginRequestUrl,
             dataType: .json,
             statusCode: 200,
             data: [.post: MockedData.userInfo1]).register()

        // then
        sut.login(email: .randomEmail(),
                  password: .randomPassword(),
                  device: .randomName())
            .sink { _ in
            } receiveValue: { userLogin in
                XCTAssertNotNil(userLogin)
                expectation.fulfill()
            }
            .store(in: &cancellableSet)

        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testLoginFailureWithErrorResponse() throws {
        // given
        let expectation = expectation(description: "errorResponse message is returned")
        let email = String.randomEmail()
        let password = String.randomPassword()
        let device = String.randomName()
        let loginRequestUrl = try XCTUnwrap(sut.endpoint.login(email: email,
                                                               password: password,
                                                               device: device).url)
        let expectedError = try JSONDecoder().decode(ErrorResponse.self, from: MockedData.errorResponse1)

        // when
        Mock(url: loginRequestUrl,
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
            }
            .store(in: &cancellableSet)

        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testLoginFailureWithUnknownErrorResponse() throws {
        // given
        let expectation = expectation(description: "errorResponse message is returned")
        let email = String.randomEmail()
        let password = String.randomPassword()
        let device = String.randomName()
        let loginRequestUrl = try XCTUnwrap(sut.endpoint.login(email: email,
                                                               password: password,
                                                               device: device).url)

        // when
        Mock(url: loginRequestUrl,
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
            }
            .store(in: &cancellableSet)

        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testLoginFailureWithServerError() throws {
        // given
        let expectation = expectation(description: "errorResponse message is returned")
        let email = String.randomEmail()
        let password = String.randomPassword()
        let device = String.randomName()
        let loginRequestUrl = try XCTUnwrap(sut.endpoint.login(email: email,
                                                               password: password,
                                                               device: device).url)

        // when
        Mock(url: loginRequestUrl,
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
            }
            .store(in: &cancellableSet)

        waitForExpectations(timeout: 5.0, handler: nil)
    }
}
