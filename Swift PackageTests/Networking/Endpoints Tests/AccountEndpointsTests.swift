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
        let expectation = expectObject(ofType: UserLogin.self)
        let loginRequest = sut.endpoint.login(email: .randomEmail(),
                                              password: .randomPassword(),
                                              device: .randomName())
        let loginUrl = try XCTUnwrap(loginRequest.url)

        // when
        Mock(url: loginUrl,
             dataType: .json,
             statusCode: 200,
             data: [.post: MockedData.userLogin1]).register()

        // then
        sut.login(email: .randomEmail(),
                  password: .randomPassword(),
                  device: .randomName())
            .sink { [weak self] fini in
                switch fini {
                case .failure: self?.shouldNotFail()
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
        let expectation = expectObject(ofType: ErrorResponse.self)
        let loginRequest = sut.endpoint.login(email: .randomEmail(),
                                              password: .randomPassword(),
                                              device: .randomName())
        let loginUrl = try XCTUnwrap(loginRequest.url)
        let errorResponse = try JSONDecoder().decode(ErrorResponse.self,
                                                     from: MockedData.errorResponse1)
        let expectedError = SLClientError.clientError(errorResponse)

        // when
        Mock(url: loginUrl,
             dataType: .json,
             statusCode: 400,
             data: [.post: MockedData.errorResponse1]).register()

        // then
        sut.login(email: .randomEmail(),
                  password: .randomPassword(),
                  device: .randomName())
            .sink { completion in
                switch completion {
                case let .failure(error):
                    XCTAssertEqual(error as? SLClientError, expectedError)
                    expectation.fulfill()
                case .finished: break
                }
            } receiveValue: { [weak self] _ in
                self?.shouldNotSucceed()
            }
            .store(in: &cancellableSet)

        waitForExpectations()
    }

    func testLoginFailureWithUnknownErrorResponse() throws {
        // given
        let expectation = expectObject(ofType: ErrorResponse.self)
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
            .sink { completion in
                switch completion {
                case let .failure(error):
                    XCTAssertEqual(error as? SLClientError, .unknown(statusCode: 406))
                    expectation.fulfill()
                case .finished: break
                }
            } receiveValue: { [weak self] _ in
                self?.shouldNotSucceed()
            }
            .store(in: &cancellableSet)

        waitForExpectations()
    }

    func testLoginFailureWithServerError() throws {
        // given
        let expectation = expectObject(ofType: ErrorResponse.self)
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
            .sink { completion in
                switch completion {
                case let .failure(error):
                    XCTAssertEqual(error as? SLClientError, .unknown(statusCode: 500))
                    expectation.fulfill()
                case .finished: break
                }
            } receiveValue: { [weak self] _ in
                self?.shouldNotSucceed()
            }
            .store(in: &cancellableSet)

        waitForExpectations()
    }
}

// MARK: - POST /api/auth/mfa
// https://github.com/simple-login/app/blob/master/docs/api.md#post-apiauthmfa
extension AccountEndpointsTests {
    func testMfaSuccess() throws {
        // given
        let expectation = expectObject(ofType: ApiKey.self)
        let mfaRequest = sut.endpoint.mfa(token: .randomPassword(),
                                          key: .randomPassword(),
                                          device: .randomName())
        let mfaUrl = try XCTUnwrap(mfaRequest.url)

        // when
        Mock(url: mfaUrl,
             dataType: .json,
             statusCode: 200,
             data: [.post: MockedData.mfa]).register()

        // then
        sut.mfa(token: .randomPassword(),
                key: .randomPassword(),
                device: .randomName())
            .sink { [weak self] completion in
                switch completion {
                case let .failure(error):
                    print(error.localizedDescription)
                    self?.shouldNotFail()
                case .finished: break
                }
            } receiveValue: { apiKey in
                XCTAssertEqual(apiKey.value, "eww3jkfeygmbdwmymniociltiabnodmibtbnc")
                expectation.fulfill()
            }
            .store(in: &cancellableSet)

        waitForExpectations()
    }

    func testMfaFailure() throws {
        // given
        let expectation = expectObject(ofType: ErrorResponse.self)
        let mfaRequest = sut.endpoint.mfa(token: .randomPassword(),
                                          key: .randomPassword(),
                                          device: .randomName())
        let mfaUrl = try XCTUnwrap(mfaRequest.url)
        let errorResponse = try JSONDecoder().decode(ErrorResponse.self,
                                                     from: MockedData.errorResponse2)
        let expectedError = SLClientError.clientError(errorResponse)

        // when
        Mock(url: mfaUrl,
             dataType: .json,
             statusCode: 400,
             data: [.post: MockedData.errorResponse2]).register()

        // then
        sut.mfa(token: .randomPassword(),
                key: .randomPassword(),
                device: .randomName())
            .sink { completion in
                switch completion {
                case let .failure(error):
                    XCTAssertEqual(error as? SLClientError, expectedError)
                    expectation.fulfill()
                case .finished: break
                }
            } receiveValue: { [weak self] _ in
                self?.shouldNotSucceed()
            }
            .store(in: &cancellableSet)

        waitForExpectations()
    }
}

// MARK: - POST /api/auth/register
// https://github.com/simple-login/app/blob/master/docs/api.md#post-apiauthregister
extension AccountEndpointsTests {
    func testRegisterSuccess() throws {
        // given
        let expectation = expectObject(ofType: MessageResponse.self)
        let registerRequest = sut.endpoint.register(email: .randomEmail(),
                                                    password: .randomPassword())
        let registerUrl = try XCTUnwrap(registerRequest.url)

        // when
        Mock(url: registerUrl,
             dataType: .json,
             statusCode: 200,
             data: [.post: MockedData.message]).register()

        // then
        sut.register(email: .randomEmail(), password: .randomPassword())
            .sink { [weak self] fini in
                switch fini {
                case .failure: self?.shouldNotFail()
                case .finished: break
                }
            } receiveValue: { _ in
                expectation.fulfill()
            }
            .store(in: &cancellableSet)

        waitForExpectations()
    }

    func testRegisterFailure() throws {
        // given
        let expectation = expectObject(ofType: ErrorResponse.self)
        let registerRequest = sut.endpoint.register(email: .randomEmail(),
                                                    password: .randomPassword())
        let registerUrl = try XCTUnwrap(registerRequest.url)
        let errorResponse = try JSONDecoder().decode(ErrorResponse.self,
                                                     from: MockedData.errorResponse3)
        let expectedError = SLClientError.clientError(errorResponse)

        // when
        Mock(url: registerUrl,
             dataType: .json,
             statusCode: 400,
             data: [.post: MockedData.errorResponse3]).register()

        // then
        sut.register(email: .randomEmail(), password: .randomPassword())
            .sink { completion in
                switch completion {
                case let .failure(error):
                    XCTAssertEqual(error as? SLClientError, expectedError)
                    expectation.fulfill()
                case .finished: break
                }
            } receiveValue: { [weak self] _ in
                self?.shouldNotSucceed()
            }
            .store(in: &cancellableSet)

        waitForExpectations()
    }
}

// MARK: - POST /api/auth/activate
// https://github.com/simple-login/app/blob/master/docs/api.md#post-apiauthactivate
extension AccountEndpointsTests {
    func testActivateSuccess() throws {
        // given
        let expectation = expectObject(ofType: MessageResponse.self)
        let activateRequest = sut.endpoint.activate(email: .randomEmail(), code: .randomName())
        let activateUrl = try XCTUnwrap(activateRequest.url)

        // when
        Mock(url: activateUrl,
             dataType: .json,
             statusCode: 200,
             data: [.post: MockedData.message]).register()

        // then
        sut.activate(email: .randomEmail(), code: .randomName())
            .sink { [weak self] fini in
                switch fini {
                case .failure: self?.shouldNotFail()
                case .finished: break
                }
            } receiveValue: { _ in
                expectation.fulfill()
            }
            .store(in: &cancellableSet)

        waitForExpectations()
    }

    func testActivateFailure() throws {
        // given
        let expectation = expectObject(ofType: ErrorResponse.self)
        let activateRequest = sut.endpoint.activate(email: .randomEmail(), code: .randomName())
        let activateUrl = try XCTUnwrap(activateRequest.url)
        let errorResponse = try JSONDecoder().decode(ErrorResponse.self,
                                                     from: MockedData.errorResponse1)
        let expectedError = SLClientError.clientError(errorResponse)

        // when
        Mock(url: activateUrl,
             dataType: .json,
             statusCode: 400,
             data: [.post: MockedData.errorResponse1]).register()

        // then
        sut.activate(email: .randomEmail(), code: .randomName())
            .sink { completion in
                switch completion {
                case let .failure(error):
                    XCTAssertEqual(error as? SLClientError, expectedError)
                    expectation.fulfill()
                case .finished: break
                }
            } receiveValue: { [weak self] _ in
                self?.shouldNotSucceed()
            }
            .store(in: &cancellableSet)

        waitForExpectations()
    }
}

// MARK: - POST /api/auth/reactivate
// https://github.com/simple-login/app/blob/master/docs/api.md#post-apiauthreactivate
extension AccountEndpointsTests {
    func testReactivateSuccess() throws {
        // given
        let expectation = expectObject(ofType: MessageResponse.self)
        let reactivateRequest = sut.endpoint.reactivate(email: .randomEmail())
        let reactivateUrl = try XCTUnwrap(reactivateRequest.url)

        // when
        Mock(url: reactivateUrl,
             dataType: .json,
             statusCode: 200,
             data: [.post: MockedData.message]).register()

        // then
        sut.reactivate(email: .randomEmail())
            .sink { [weak self] fini in
                switch fini {
                case .failure: self?.shouldNotFail()
                case .finished: break
                }
            } receiveValue: { _ in
                expectation.fulfill()
            }
            .store(in: &cancellableSet)

        waitForExpectations()
    }

    func testReactivateFailure() throws {
        // given
        let expectation = expectObject(ofType: ErrorResponse.self)
        let reactivateRequest = sut.endpoint.reactivate(email: .randomEmail())
        let reactivateUrl = try XCTUnwrap(reactivateRequest.url)
        let errorResponse = try JSONDecoder().decode(ErrorResponse.self,
                                                     from: MockedData.errorResponse2)
        let expectedError = SLClientError.clientError(errorResponse)

        // when
        Mock(url: reactivateUrl,
             dataType: .json,
             statusCode: 400,
             data: [.post: MockedData.errorResponse2]).register()

        // then
        sut.reactivate(email: .randomEmail())
            .sink { completion in
                switch completion {
                case let .failure(error):
                    XCTAssertEqual(error as? SLClientError, expectedError)
                    expectation.fulfill()
                case .finished: break
                }
            } receiveValue: { [weak self] _ in
                self?.shouldNotSucceed()
            }
            .store(in: &cancellableSet)

        waitForExpectations()
    }
}

// MARK: - POST /api/auth/forgot_password
// https://github.com/simple-login/app/blob/master/docs/api.md#post-apiauthforgot_password
extension AccountEndpointsTests {
    func testForgotPasswordSuccess() throws {
        // given
        let expectation = expectObject(ofType: OkResponse.self)
        let forgotPasswordRequest = sut.endpoint.forgotPassword(email: .randomEmail())
        let forgotPasswordUrl = try XCTUnwrap(forgotPasswordRequest.url)

        // when
        Mock(url: forgotPasswordUrl,
             dataType: .json,
             statusCode: 200,
             data: [.post: MockedData.ok]).register()

        // then
        sut.forgotPassword(email: .randomEmail())
            .sink { [weak self] fini in
                switch fini {
                case .failure: self?.shouldNotFail()
                case .finished: break
                }
            } receiveValue: { _ in
                expectation.fulfill()
            }
            .store(in: &cancellableSet)

        waitForExpectations()
    }

    func testForgotPasswordFailure() throws {
        // given
        let expectation = expectObject(ofType: ErrorResponse.self)
        let forgotPasswordRequest = sut.endpoint.forgotPassword(email: .randomEmail())
        let forgotPasswordUrl = try XCTUnwrap(forgotPasswordRequest.url)
        let errorResponse = try JSONDecoder().decode(ErrorResponse.self,
                                                     from: MockedData.errorResponse3)
        let expectedError = SLClientError.clientError(errorResponse)

        // when
        Mock(url: forgotPasswordUrl,
             dataType: .json,
             statusCode: 400,
             data: [.post: MockedData.errorResponse3]).register()

        // then
        sut.forgotPassword(email: .randomEmail())
            .sink { completion in
                switch completion {
                case let .failure(error):
                    XCTAssertEqual(error as? SLClientError, expectedError)
                    expectation.fulfill()
                case .finished: break
                }
            } receiveValue: { [weak self] _ in
                self?.shouldNotSucceed()
            }
            .store(in: &cancellableSet)

        waitForExpectations()
    }
}

// MARK: - GET /api/user_info
// https://github.com/simple-login/app/blob/master/docs/api.md#get-apiuser_info
extension AccountEndpointsTests {
    func testGetUserInfoSuccess() throws {
        // given
        let expectation = expectObject(ofType: UserInfo.self)
        let getUserInfoRequest = sut.endpoint.getUserInfo(apiKey: .random())
        let getUserInfoUrl = try XCTUnwrap(getUserInfoRequest.url)

        // when
        Mock(url: getUserInfoUrl,
             dataType: .json,
             statusCode: 200,
             data: [.get: MockedData.userInfo2]).register()

        // then
        sut.getUserInfo(apiKey: .random())
            .sink { [weak self] fini in
                switch fini {
                case .failure: self?.shouldNotFail()
                case .finished: break
                }
            } receiveValue: { _ in
                expectation.fulfill()
            }
            .store(in: &cancellableSet)

        waitForExpectations()
    }

    func testGetUserInfoFailure() throws {
        // given
        let expectation = expectObject(ofType: ErrorResponse.self)
        let getUserInfoRequest = sut.endpoint.getUserInfo(apiKey: .random())
        let getUserInfoUrl = try XCTUnwrap(getUserInfoRequest.url)
        let errorResponse = try JSONDecoder().decode(ErrorResponse.self,
                                                     from: MockedData.errorResponse1)
        let expectedError = SLClientError.clientError(errorResponse)

        // when
        Mock(url: getUserInfoUrl,
             dataType: .json,
             statusCode: 400,
             data: [.get: MockedData.errorResponse1]).register()

        // then
        sut.getUserInfo(apiKey: .random())
            .sink { completion in
                switch completion {
                case let .failure(error):
                    XCTAssertEqual(error as? SLClientError, expectedError)
                    expectation.fulfill()
                case .finished: break
                }
            } receiveValue: { [weak self] _ in
                self?.shouldNotSucceed()
            }
            .store(in: &cancellableSet)

        waitForExpectations()
    }
}

// MARK: - PATCH /api/user_info
// https://github.com/simple-login/app/blob/master/docs/api.md#patch-apiuser_info
extension AccountEndpointsTests {
    func testUpdateProfilePictureSuccess() throws {
        // given
        let expectation = expectObject(ofType: UserInfo.self)
        let updateProfilePictureRequest =
            sut.endpoint.updateProfilePicture(apiKey: .random(),
                                              profilePicture: .randomNullableName())
        let updateProfilePictureUrl = try XCTUnwrap(updateProfilePictureRequest.url)

        // when
        Mock(url: updateProfilePictureUrl,
             dataType: .json,
             statusCode: 200,
             data: [.patch: MockedData.userInfo1]).register()

        // then
        sut.updateProfilePicture(apiKey: .random(),
                                 base64ProfilePicture: .randomNullableName())
            .sink { [weak self] fini in
                switch fini {
                case .failure: self?.shouldNotFail()
                case .finished: break
                }
            } receiveValue: { _ in
                expectation.fulfill()
            }
            .store(in: &cancellableSet)

        waitForExpectations()
    }

    func testUpdateProfilePictureFailure() throws {
        // given
        let expectation = expectObject(ofType: ErrorResponse.self)
        let updateProfilePictureRequest =
            sut.endpoint.updateProfilePicture(apiKey: .random(),
                                              profilePicture: .randomNullableName())
        let updateProfilePictureUrl = try XCTUnwrap(updateProfilePictureRequest.url)
        let errorResponse = try JSONDecoder().decode(ErrorResponse.self,
                                                     from: MockedData.errorResponse1)
        let expectedError = SLClientError.clientError(errorResponse)

        // when
        Mock(url: updateProfilePictureUrl,
             dataType: .json,
             statusCode: 400,
             data: [.patch: MockedData.errorResponse1]).register()

        // then
        sut.updateProfilePicture(apiKey: .random(), base64ProfilePicture: .randomNullableName())
            .sink { completion in
                switch completion {
                case let .failure(error):
                    XCTAssertEqual(error as? SLClientError, expectedError)
                    expectation.fulfill()
                case .finished: break
                }
            } receiveValue: { [weak self] _ in
                self?.shouldNotSucceed()
            }
            .store(in: &cancellableSet)

        waitForExpectations()
    }

    func testUpdateProfileNameSuccess() throws {
        // given
        let expectation = expectObject(ofType: UserInfo.self)
        let updateProfileNameRequest = sut.endpoint.updateProfileName(apiKey: .random(),
                                                                      name: .randomNullableName())
        let updateProfileNameUrl = try XCTUnwrap(updateProfileNameRequest.url)

        // when
        Mock(url: updateProfileNameUrl,
             dataType: .json,
             statusCode: 200,
             data: [.patch: MockedData.userInfo1]).register()

        // then
        sut.updateProfileName(apiKey: .random(),
                              name: .randomNullableName())
            .sink { [weak self] fini in
                switch fini {
                case .failure: self?.shouldNotFail()
                case .finished: break
                }
            } receiveValue: { _ in
                expectation.fulfill()
            }
            .store(in: &cancellableSet)

        waitForExpectations()
    }

    func testUpdateProfileNameFailure() throws {
        // given
        let expectation = expectObject(ofType: ErrorResponse.self)
        let updateProfileNameRequest = sut.endpoint.updateProfileName(apiKey: .random(),
                                                                      name: .randomNullableName())
        let updateProfileNameUrl = try XCTUnwrap(updateProfileNameRequest.url)
        let errorResponse = try JSONDecoder().decode(ErrorResponse.self,
                                                     from: MockedData.errorResponse1)
        let expectedError = SLClientError.clientError(errorResponse)

        // when
        Mock(url: updateProfileNameUrl,
             dataType: .json,
             statusCode: 400,
             data: [.patch: MockedData.errorResponse1]).register()

        // then
        sut.updateProfileName(apiKey: .random(), name: .randomNullableName())
            .sink { completion in
                switch completion {
                case let .failure(error):
                    XCTAssertEqual(error as? SLClientError, expectedError)
                    expectation.fulfill()
                case .finished: break
                }
            } receiveValue: { [weak self] _ in
                self?.shouldNotSucceed()
            }
            .store(in: &cancellableSet)

        waitForExpectations()
    }
}
