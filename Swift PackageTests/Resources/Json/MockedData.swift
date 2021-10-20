//
//  MockedData.swift
//  Swift PackageTests
//
//  Created by Thanh-Nhon Nguyen on 04/06/2021.
//

import Foundation

// swiftlint:disable convenience_type
// swiftlint:disable force_unwrapping
// swiftlint:disable force_try
final class MockedData {
    private static let bundle = Bundle(for: MockedData.self)

    private static func jsonData(forJsonName name: String) -> Data {
        try! Data(contentsOf: bundle.url(forResource: name, withExtension: "json")!)
    }

    static let alias = jsonData(forJsonName: "Alias")
    static let aliasActivity = jsonData(forJsonName: "AliasActivity")
    static let aliasOptions = jsonData(forJsonName: "AliasOptions")
    static let contact1 = jsonData(forJsonName: "Contact1")
    static let contact2 = jsonData(forJsonName: "Contact2")
    static let customDomain1 = jsonData(forJsonName: "CustomDomain1")
    static let customDomain2 = jsonData(forJsonName: "CustomDomain2")
    static let dummy = jsonData(forJsonName: "Dummy")
    static let errorResponse1 = jsonData(forJsonName: "ErrorResponse1")
    static let errorResponse2 = jsonData(forJsonName: "ErrorResponse2")
    static let errorResponse3 = jsonData(forJsonName: "ErrorResponse3")
    static let mailbox = jsonData(forJsonName: "Mailbox")
    static let message = jsonData(forJsonName: "Message")
    static let mfa = jsonData(forJsonName: "Mfa")
    static let userInfo1 = jsonData(forJsonName: "UserInfo1")
    static let userInfo2 = jsonData(forJsonName: "UserInfo2")
    static let userLogin1 = jsonData(forJsonName: "UserLogin1")
    static let userLogin2 = jsonData(forJsonName: "UserLogin2")
    static let userSettings = jsonData(forJsonName: "UserSettings")
    static let ok = jsonData(forJsonName: "Ok")
}
