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
public extension SLClient {
    func login(email: String, password: String, device: String) -> AnyPublisher<UserLogin, SLClientError> {
        let request = endpoint.login(email: email, password: password, device: device)
        return perform(request)
    }

    func mfa(token: String, key: String, device: String) -> AnyPublisher<ApiKey, SLClientError> {
        let request = endpoint.mfa(token: token, key: key, device: device)
        return perform(request)
    }

    func register(email: String, password: String) -> AnyPublisher<MessageResponse, SLClientError> {
        let request = endpoint.register(email: email, password: password)
        return perform(request)
    }

    func activate(email: String, code: String) -> AnyPublisher<MessageResponse, SLClientError> {
        let request = endpoint.activate(email: email, code: code)
        return perform(request)
    }

    func reactivate(email: String) -> AnyPublisher<MessageResponse, SLClientError> {
        let request = endpoint.reactivate(email: email)
        return perform(request)
    }

    func forgotPassword(email: String) -> AnyPublisher<OkResponse, SLClientError> {
        let request = endpoint.forgotPassword(email: email)
        return perform(request)
    }

    func getUserInfo(apiKey: ApiKey) -> AnyPublisher<UserInfo, SLClientError> {
        let request = endpoint.getUserInfo(apiKey: apiKey)
        return perform(request)
    }

    func updateProfilePicture(apiKey: ApiKey,
                              base64ProfilePicture: String?) -> AnyPublisher<UserInfo, SLClientError> {
        let request = endpoint.updateProfilePicture(apiKey: apiKey,
                                                    profilePicture: base64ProfilePicture)
        return perform(request)
    }

    func updateProfileName(apiKey: ApiKey, name: String?) -> AnyPublisher<UserInfo, SLClientError> {
        let request = endpoint.updateProfileName(apiKey: apiKey, name: name)
        return perform(request)
    }
}

// MARK: - Alias
extension SLClient {
    func getAliasOptions(apiKey: ApiKey, hostname: String?) -> AnyPublisher<AliasOptions, SLClientError> {
        let request = endpoint.getAliasOptions(apiKey: apiKey, hostname: hostname)
        return perform(request)
    }

    func createAlias(apiKey: ApiKey, options: AliasCreationOptions) -> AnyPublisher<Alias, SLClientError> {
        let request = endpoint.createAlias(apiKey: apiKey, options: options)
        return perform(request)
    }

    func randomAlias(apiKey: ApiKey, options: AliasRandomOptions) -> AnyPublisher<Alias, SLClientError> {
        let request = endpoint.randomAlias(apiKey: apiKey, options: options)
        return perform(request)
    }

    func getAliases(apiKey: ApiKey, page: Int) -> AnyPublisher<AliasArray, SLClientError> {
        let request = endpoint.getAliases(apiKey: apiKey, page: page)
        return perform(request)
    }

    func getAlias(apiKey: ApiKey, id: Int) -> AnyPublisher<Alias, SLClientError> {
        let request = endpoint.getAlias(apiKey: apiKey, id: id)
        return perform(request)
    }

    func deleteAlias(apiKey: ApiKey, id: Int) -> AnyPublisher<DeletedResponse, SLClientError> {
        let request = endpoint.deleteAlias(apiKey: apiKey, id: id)
        return perform(request)
    }

    func toggleAliasStatus(apiKey: ApiKey, id: Int) -> AnyPublisher<EnabledResponse, SLClientError> {
        let request = endpoint.toggleAliasStatus(apiKey: apiKey, id: id)
        return perform(request)
    }

    func getAliasActivities(apiKey: ApiKey,
                            id: Int,
                            page: Int) -> AnyPublisher<AliasActivityArray, SLClientError> {
        let request = endpoint.getAliasActivities(apiKey: apiKey, id: id, page: page)
        return perform(request)
    }

    func updateAlias(apiKey: ApiKey, id: Int, option: AliasUpdateOption) -> AnyPublisher<Alias, SLClientError> {
        let request = endpoint.updateAlias(apiKey: apiKey, id: id, option: option)
        return perform(request)
    }

    func getAliasContacts(apiKey: ApiKey, id: Int, page: Int) -> AnyPublisher<ContactArray, SLClientError> {
        let request = endpoint.getAliasContacts(apiKey: apiKey, id: id, page: page)
        return perform(request)
    }

    func createContact(apiKey: ApiKey,
                       aliasId: Int,
                       contactEmail: String) -> AnyPublisher<Contact, SLClientError> {
        let request = endpoint.createContact(apiKey: apiKey, aliasId: aliasId, contactEmail: contactEmail)
        return perform(request)
    }
}

// MARK: - Mailbox
extension SLClient {
    func getMailboxes(apiKey: ApiKey) -> AnyPublisher<MailboxArray, SLClientError> {
        let request = endpoint.getMailboxes(apiKey: apiKey)
        return perform(request)
    }

    func createMailbox(apiKey: ApiKey, email: String) -> AnyPublisher<Mailbox, SLClientError> {
        let request = endpoint.createMailbox(apiKey: apiKey, email: email)
        return perform(request)
    }

    func deleteMailbox(apiKey: ApiKey, id: Int) -> AnyPublisher<DeletedResponse, SLClientError> {
        let request = endpoint.deleteMailbox(apiKey: apiKey, id: id)
        return perform(request)
    }

    func updateMailbox(apiKey: ApiKey,
                       id: Int,
                       option: MailboxUpdateOption) -> AnyPublisher<Mailbox, SLClientError> {
        let request = endpoint.updateMailbox(apiKey: apiKey, id: id, option: option)
        return perform(request)
    }
}

// MARK: - Custom domain
extension SLClient {
    func getCustomDomains(apiKey: ApiKey) -> AnyPublisher<[CustomDomain], SLClientError> {
        let request = endpoint.getCustomDomains(apiKey: apiKey)
        return perform(request)
    }

    func updateCustomDomain(apiKey: ApiKey,
                            id: Int,
                            option: CustomDomainUpdateOption) -> AnyPublisher<CustomDomain, SLClientError> {
        let request = endpoint.updateCustomDomain(apiKey: apiKey, id: id, option: option)
        return perform(request)
    }
}
