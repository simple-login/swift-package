//
// GetStatsEndpoint.swift
// SimpleLogin - Created on 05/02/2024.
// Copyright (c) 2024 Proton Technologies AG
//
// This file is part of SimpleLogin.
//
// SimpleLogin is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// SimpleLogin is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with SimpleLogin. If not, see https://www.gnu.org/licenses/.
//

import Foundation

// GET /api/stats
// https://github.com/simple-login/app/blob/master/docs/api.md#get-apistats
public struct GetStatsEndpoint: Endpoint {
    public typealias Body = EmptyBody
    public typealias Response = Stats

    public var path: String
    public var method: HTTPMethod
    public var apiKey: String?

    public init(apiKey: String) {
        self.path = "/api/stats"
        self.method = .get
        self.apiKey = apiKey
    }
}
