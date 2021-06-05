//
//  StringExtensions.swift
//  Swift PackageTests
//
//  Created by Thanh-Nhon Nguyen on 05/06/2021.
//

import Foundation

enum AllowedLetters: String {
    case lowercase = "abcdefghijklmnopqrstuvwxyz"
    case lowercaseUppercase = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    case lowercaseUppercaseDigit = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
}

// swiftlint:disable force_unwrapping
extension String {
    static func random(allowedLetters: AllowedLetters, length: Int) -> String {
        String((0..<length).map { _ in allowedLetters.rawValue.randomElement()! })
    }

    static func randomName() -> String {
        random(allowedLetters: .lowercaseUppercaseDigit, length: 20)
    }

    static func randomNullableName() -> String? {
        let isNull = Bool.random()

        if isNull { return nil }
        return randomName()
    }

    static func randomEmail() -> String {
        let username = random(allowedLetters: .lowercase, length: 10)
        let hostName = random(allowedLetters: .lowercase, length: 10)
        let hostDomain = random(allowedLetters: .lowercase, length: 10)

        return "\(username)@\(hostName).\(hostDomain)"
    }

    static func randomPassword() -> String {
        random(allowedLetters: .lowercaseUppercaseDigit, length: 100)
    }

    static func randomDeviceName() -> String {
        random(allowedLetters: .lowercaseUppercaseDigit, length: 15)
    }

    static func randomUrlString() -> String {
        let hostName = random(allowedLetters: .lowercase, length: 10)
        let hostDomain = random(allowedLetters: .lowercase, length: 10)

        return "https://\(hostName).\(hostDomain)"
    }
}
