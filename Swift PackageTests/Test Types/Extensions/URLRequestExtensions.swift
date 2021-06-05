//
//  URLRequestExtensions.swift
//  Swift PackageTests
//
//  Created by Thanh-Nhon Nguyen on 05/06/2021.
//

import Foundation

extension URLRequest {
    var bodyDict: [String: Any]? {
        guard let bodyData = httpBody else { return nil }
        return try? JSONSerialization.jsonObject(with: bodyData) as? [String: Any]
    }
}
