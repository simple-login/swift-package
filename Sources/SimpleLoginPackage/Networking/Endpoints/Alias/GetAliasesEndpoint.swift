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
    public typealias Body = SearchAliasesRequest
    public typealias Response = AliasArray

    public var path: String
    public var method: HTTPMethod
    public var apiKey: String?
    public var body: SearchAliasesRequest?
    public var parameters: [String: String?]?

    public init(apiKey: String, page: Int, option: GetAliasesOption) {
        self.path = "/api/v2/aliases"

        var parameters: [String: String?] = ["page_id": "\(page)"]
        switch option {
        case .search(let query):
            self.method = .post
            self.body = .init(query: query)
        case .filter(let option):
            self.method = .get
            if let option {
                parameters.updateValue(nil, forKey: option.rawValue)
            }
        }

        self.apiKey = apiKey
        self.parameters = parameters
    }
}

public enum GetAliasesOption {
    case search(query: String)
    case filter(AliasFilterOption?)
}

public enum AliasFilterOption: String {
    case disabled = "disabled"
    case enabled = "enabled"
    case pinned = "pinned"
}

public struct SearchAliasesRequest: Encodable {
    let query: String
}
