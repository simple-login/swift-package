//
//  SLClient.swift
//  Swift Package
//
//  Created by Thanh-Nhon Nguyen on 04/06/2021.
//

import Combine
import Foundation

enum HttpMethod {
    static let delete = "DELETE"
    static let get = "GET"
    static let patch = "PATCH"
    static let post = "POST"
    static let put = "PUT"
}

public struct SLClient {
    let endpoint: Endpoint
    let session: URLSession

    public init?(session: URLSession, baseUrlString: String = "https://simplelogin.io/") {
        guard let baseUrl = URL(string: baseUrlString) else { return nil }
        self.endpoint = Endpoint(baseUrl: baseUrl)
        self.session = session
    }

    private func perform<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, SLClientError> {
        session.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw SLClientError.invalidServerResponse
                }

                switch httpResponse.statusCode {
                case 200...299: return data
                case 400...499:
                    if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                        throw SLClientError.clientError(errorResponse)
                    } else {
                        throw SLClientError.unknown(statusCode: httpResponse.statusCode)
                    }
                default: throw SLClientError.unknown(statusCode: httpResponse.statusCode)
                }
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> SLClientError in
                if let slClientEror = error as? SLClientError {
                    return slClientEror
                }

                return SLClientError.other(error)
            }
            .eraseToAnyPublisher()
    }
}

// MARK: - Login
extension SLClient {
    func login(email: String, password: String, device: String) -> AnyPublisher<UserLogin, SLClientError> {
        let request = endpoint.login(email: email, password: password, device: device)
        return perform(request)
    }
}
