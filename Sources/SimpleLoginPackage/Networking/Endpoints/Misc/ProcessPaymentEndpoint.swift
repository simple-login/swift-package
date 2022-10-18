//
//  ProcessPaymentEndpoint.swift
//  Swift Package
//
//  Created by Nhon Proton on 18/10/2022.
//

import Foundation

// POST /api/apple/process_payment
// https://github.com/simple-login/app/blob/master/docs/api.md#post-apiappleprocess_payment
public struct ProcessPaymentEndpoint: EndpointV2 {
    public typealias Body = ProcessPaymentRequest
    public typealias Response = OkResponse

    public var path: String
    public var method: HTTPMethod
    public var apiKey: String?
    public var body: ProcessPaymentRequest?

    public init(apiKey: String, receiptData: String, isMacApp: Bool) {
        self.path = "/api/apple/process_payment"
        self.method = .post
        self.apiKey = apiKey
        self.body = .init(receiptData: receiptData, isMacApp: isMacApp)
    }
}

public struct ProcessPaymentRequest: Encodable {
    let receiptData: String
    let isMacApp: Bool

    private enum CodingKeys: String, CodingKey {
        case receiptData = "receipt_data"
        case isMacApp = "is_macapp"
    }
}
