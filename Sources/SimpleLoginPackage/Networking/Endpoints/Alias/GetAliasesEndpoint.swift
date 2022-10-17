//
//  GetAliasesEndpoint.swift
//  Swift Package
//
//  Created by Nhon Proton on 17/10/2022.
//

import Foundation

// GET /api/v2/aliases
// https://github.com/simple-login/app/blob/master/docs/api.md#get-apiv2aliases
public struct GetAliasesEndpoint: EndpointV2 {
    public typealias Body = EmptyBody
    public typealias Response = AliasArray

    public var path: String
    public var method: HTTPMethod
    public var apiKey: String?
    public var parameters: [String: String?]?

    public init(apiKey: String, page: Int, option: AliasFilterOption?) {
        self.path = "/api/v2/aliases"
        self.method = .get
        self.apiKey = apiKey
        var parameters: [String: String?] = ["page_id": "\(page)"]
        if let option {
            parameters.updateValue(nil, forKey: option.rawValue)
        }
        self.parameters = parameters
    }
}

public enum AliasFilterOption: String {
    case disabled = "disabled"
    case enabled = "enabled"
    case pinned = "pinned"
}
