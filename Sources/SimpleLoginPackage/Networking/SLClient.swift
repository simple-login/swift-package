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

    private func perform<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
        session.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw SLClientError.invalidServerResponse
                }

                switch httpResponse.statusCode {
                case 200...299: return data
                case 400...499:
                    if var errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                        errorResponse.statusCode = httpResponse.statusCode
                        throw SLClientError.clientError(errorResponse)
                    } else {
                        throw SLClientError.unknown(statusCode: httpResponse.statusCode)
                    }
                default: throw SLClientError.unknown(statusCode: httpResponse.statusCode)
                }
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

// MARK: - Login
public extension SLClient {
    func login(email: String, password: String, device: String) -> AnyPublisher<UserLogin, Error> {
        let request = endpoint.login(email: email, password: password, device: device)
        return perform(request)
    }

    func mfa(token: String, key: String, device: String) -> AnyPublisher<ApiKey, Error> {
        let request = endpoint.mfa(token: token, key: key, device: device)
        return perform(request)
    }

    func register(email: String, password: String) -> AnyPublisher<MessageResponse, Error> {
        let request = endpoint.register(email: email, password: password)
        return perform(request)
    }

    func activate(email: String, code: String) -> AnyPublisher<MessageResponse, Error> {
        let request = endpoint.activate(email: email, code: code)
        return perform(request)
    }

    func reactivate(email: String) -> AnyPublisher<MessageResponse, Error> {
        let request = endpoint.reactivate(email: email)
        return perform(request)
    }

    func forgotPassword(email: String) -> AnyPublisher<OkResponse, Error> {
        let request = endpoint.forgotPassword(email: email)
        return perform(request)
    }

    func getUserInfo(apiKey: ApiKey) -> AnyPublisher<UserInfo, Error> {
        let request = endpoint.getUserInfo(apiKey: apiKey)
        return perform(request)
    }

    func updateProfilePicture(apiKey: ApiKey,
                              base64ProfilePicture: String?) -> AnyPublisher<UserInfo, Error> {
        let request = endpoint.updateProfilePicture(apiKey: apiKey,
                                                    profilePicture: base64ProfilePicture)
        return perform(request)
    }

    func updateProfileName(apiKey: ApiKey, name: String?) -> AnyPublisher<UserInfo, Error> {
        let request = endpoint.updateProfileName(apiKey: apiKey, name: name)
        return perform(request)
    }
}

// MARK: - Alias
public extension SLClient {
    func getAliasOptions(apiKey: ApiKey, hostname: String?) -> AnyPublisher<AliasOptions, Error> {
        let request = endpoint.getAliasOptions(apiKey: apiKey, hostname: hostname)
        return perform(request)
    }

    func createAlias(apiKey: ApiKey, options: AliasCreationOptions) -> AnyPublisher<Alias, Error> {
        let request = endpoint.createAlias(apiKey: apiKey, options: options)
        return perform(request)
    }

    func randomAlias(apiKey: ApiKey, options: AliasRandomOptions) -> AnyPublisher<Alias, Error> {
        let request = endpoint.randomAlias(apiKey: apiKey, options: options)
        return perform(request)
    }

    func getAliases(apiKey: ApiKey, page: Int) -> AnyPublisher<AliasArray, Error> {
        let request = endpoint.getAliases(apiKey: apiKey, page: page)
        return perform(request)
    }

    func getAlias(apiKey: ApiKey, id: Int) -> AnyPublisher<Alias, Error> {
        let request = endpoint.getAlias(apiKey: apiKey, id: id)
        return perform(request)
    }

    func deleteAlias(apiKey: ApiKey, id: Int) -> AnyPublisher<DeletedResponse, Error> {
        let request = endpoint.deleteAlias(apiKey: apiKey, id: id)
        return perform(request)
    }

    func toggleAliasStatus(apiKey: ApiKey, id: Int) -> AnyPublisher<EnabledResponse, Error> {
        let request = endpoint.toggleAliasStatus(apiKey: apiKey, id: id)
        return perform(request)
    }

    func getAliasActivities(apiKey: ApiKey,
                            id: Int,
                            page: Int) -> AnyPublisher<AliasActivityArray, Error> {
        let request = endpoint.getAliasActivities(apiKey: apiKey, id: id, page: page)
        return perform(request)
    }

    func updateAlias(apiKey: ApiKey,
                     id: Int,
                     option: AliasUpdateOption) -> AnyPublisher<OkResponse, Error> {
        let request = endpoint.updateAlias(apiKey: apiKey, id: id, option: option)
        return perform(request)
    }

    func getAliasContacts(apiKey: ApiKey, id: Int, page: Int) -> AnyPublisher<ContactArray, Error> {
        let request = endpoint.getAliasContacts(apiKey: apiKey, id: id, page: page)
        return perform(request)
    }

    func createContact(apiKey: ApiKey,
                       aliasId: Int,
                       contactEmail: String) -> AnyPublisher<Contact, Error> {
        let request = endpoint.createContact(apiKey: apiKey, aliasId: aliasId, contactEmail: contactEmail)
        return perform(request)
    }
}

// MARK: - Mailbox
public extension SLClient {
    func getMailboxes(apiKey: ApiKey) -> AnyPublisher<MailboxArray, Error> {
        let request = endpoint.getMailboxes(apiKey: apiKey)
        return perform(request)
    }

    func createMailbox(apiKey: ApiKey, email: String) -> AnyPublisher<Mailbox, Error> {
        let request = endpoint.createMailbox(apiKey: apiKey, email: email)
        return perform(request)
    }

    func deleteMailbox(apiKey: ApiKey, id: Int) -> AnyPublisher<DeletedResponse, Error> {
        let request = endpoint.deleteMailbox(apiKey: apiKey, id: id)
        return perform(request)
    }

    func updateMailbox(apiKey: ApiKey,
                       id: Int,
                       option: MailboxUpdateOption) -> AnyPublisher<UpdateResponse, Error> {
        let request = endpoint.updateMailbox(apiKey: apiKey, id: id, option: option)
        return perform(request)
    }
}

// MARK: - Custom domain
public extension SLClient {
    func getCustomDomains(apiKey: ApiKey) -> AnyPublisher<CustomDomainArray, Error> {
        let request = endpoint.getCustomDomains(apiKey: apiKey)
        return perform(request)
    }

    func updateCustomDomain(apiKey: ApiKey,
                            id: Int,
                            option: CustomDomainUpdateOption) -> AnyPublisher<CustomDomain, Error> {
        let request = endpoint.updateCustomDomain(apiKey: apiKey, id: id, option: option)
        return perform(request)
    }

    func getDeletedAliases(apiKey: ApiKey, customDomainId: Int) -> AnyPublisher<DeletedAliasArray, Error> {
        let request = endpoint.getDeletedAliases(apiKey: apiKey, customDomainId: customDomainId)
        return perform(request)
    }
}

// MARK: - Contact
public extension SLClient {
    func deleteContact(apiKey: ApiKey, id: Int) -> AnyPublisher<DeletedResponse, Error> {
        let request = endpoint.deleteContact(apiKey: apiKey, id: id)
        return perform(request)
    }

    func toggleContact(apiKey: ApiKey, id: Int) -> AnyPublisher<BlockForward, Error> {
        let request = endpoint.toggleContact(apiKey: apiKey, id: id)
        return perform(request)
    }
}

// MARK: - Settings
public extension SLClient {
    func getUserSettings(apiKey: ApiKey) -> AnyPublisher<UserSettings, Error> {
        let request = endpoint.getUserSettings(apiKey: apiKey)
        return perform(request)
    }

    func updateUserSettings(apiKey: ApiKey,
                            option: UserSettingsUpdateOption) -> AnyPublisher<UserSettings, Error> {
        let request = endpoint.updateUserSettings(apiKey: apiKey, option: option)
        return perform(request)
    }

    func getUsableDomains(apiKey: ApiKey) -> AnyPublisher<[UsableDomain], Error> {
        let request = endpoint.getUsableDomains(apiKey: apiKey)
        return perform(request)
    }
}

public extension SLClient {
    func processPayment(apiKey: ApiKey,
                        receiptData: String,
                        isMacApp: Bool) -> AnyPublisher<OkResponse, Error> {
        let request = endpoint.processPayment(apiKey: apiKey,
                                              receiptData: receiptData,
                                              isMacApp: isMacApp)
        return perform(request)
    }
}
