//
//  AliasEndpointsTests.swift
//  Swift PackageTests
//
//  Created by Thanh-Nhon Nguyen on 15/09/2021.
//

import Combine
import Mocker
@testable import Swift_Package
import XCTest

final class AliasEndpointsTests: BaseEndpointsTests {}

// MARK: - GET /api/v5/alias/options
// https://github.com/simple-login/app/blob/master/docs/api.md#get-apiv5aliasoptions
extension AliasEndpointsTests {
    func testGetAliasOptionsSuccess() throws {
        // given
        let expectation = expectObject(ofType: AliasOptions.self)
        let getAliasOptionsRequest = sut.endpoint.getAliasOptions(apiKey: .random(),
                                                                  hostname: nil)
        let getAliasOptionsUrl = try XCTUnwrap(getAliasOptionsRequest.url)

        // when
        Mock(url: getAliasOptionsUrl,
             dataType: .json,
             statusCode: 200,
             data: [.get: MockedData.aliasOptions]).register()

        // then
        sut.getAliasOptions(apiKey: .random(), hostname: nil)
            .sink { [weak self] completion in
                switch completion {
                case .failure: self?.shouldNotFail()
                case .finished: break
                }
            } receiveValue: { _ in
                expectation.fulfill()
            }
            .store(in: &cancellableSet)

        waitForExpectations()
    }

    func testGetAliasOptionsFailure() throws {
        // given
        // given
        let expectation = expectObject(ofType: AliasOptions.self)
        let getAliasOptionsRequest = sut.endpoint.getAliasOptions(apiKey: .random(),
                                                                  hostname: nil)
        let getAliasOptionsUrl = try XCTUnwrap(getAliasOptionsRequest.url)

        // when
        Mock(url: getAliasOptionsUrl,
             dataType: .json,
             statusCode: 200,
             data: [.get: MockedData.aliasOptions]).register()
        let errorResponse = try JSONDecoder().decode(ErrorResponse.self,
                                                     from: MockedData.errorResponse1)
        let expectedError = SLClientError.clientError(errorResponse)

        // when
        Mock(url: getAliasOptionsUrl,
             dataType: .json,
             statusCode: 400,
             data: [.get: MockedData.errorResponse1]).register()

        // then
        sut.getAliasOptions(apiKey: .random(), hostname: nil)
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
