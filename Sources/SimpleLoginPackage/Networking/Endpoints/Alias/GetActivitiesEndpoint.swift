//
//  GetActivitiesEndpoint.swift
//  Swift Package
//
//  Created by Nhon Proton on 18/10/2022.
//

import Foundation

// GET /api/aliases/:alias_id/activities
// https://github.com/simple-login/app/blob/master/docs/api.md#get-apialiasesalias_idactivities
public struct GetActivitiesEndpoint: EndpointV2 {
    public typealias Body = EmptyBody
    public typealias Response = AliasActivityArray

    public var path: String
    public var method: HTTPMethod
    public var apiKey: String?
    public var parameters: [String: String?]?

    public init(apiKey: String, aliasID: AliasID, page: Int) {
        self.path = "/api/aliases/\(aliasID)/activities"
        self.method = .get
        self.apiKey = apiKey
        self.parameters = ["page_id": "\(page)"]
    }
}
