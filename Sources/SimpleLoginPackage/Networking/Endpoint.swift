//
//  Endpoint.swift
//  Swift PackageTests
//
//  Created by Thanh-Nhon Nguyen on 05/06/2021.
//

import Foundation

extension URL {
    func appending(path: String, queryItems: [URLQueryItem]? = nil) -> URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryItems

        guard let newUrl = components.url else {
            fatalError("""
                Error appending:
                - Path: \(path)
                - QueryItems: \(String(describing: queryItems))
                - To: \(self)
                """)
        }
        return newUrl
    }
}

extension URLRequest {
    mutating func addApiKeyToHeaders(_ apiKey: ApiKey) {
        addValue(apiKey.value, forHTTPHeaderField: "Authentication")
    }

    mutating func addJsonRequestBody(_ dict: [String: Any?]) {
        httpBody = try? JSONSerialization.data(withJSONObject: dict)
        addValue("application/json", forHTTPHeaderField: "Content-Type")
    }
}

struct Endpoint {
    var baseUrl: URL
}

// MARK: - Account
extension Endpoint {
    // MARK: - POST /api/auth/login
    // https://github.com/simple-login/app/blob/master/docs/api.md#post-apiauthlogin
    func login(email: String, password: String, device: String) -> URLRequest {
        let url = baseUrl.appending(path: "/api/auth/login")
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.post
        request.addJsonRequestBody(["email": email,
                                    "password": password,
                                    "device": device])
        return request
    }

    // MARK: - POST /api/auth/mfa
    // https://github.com/simple-login/app/blob/master/docs/api.md#post-apiauthmfa
    func mfa(token: String, key: String, device: String) -> URLRequest {
        let url = baseUrl.appending(path: "/api/auth/mfa")
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.post
        request.addJsonRequestBody(["mfa_token": token,
                                    "mfa_key": key,
                                    "device": device])
        return request
    }

    // MARK: - POST /api/auth/register
    // https://github.com/simple-login/app/blob/master/docs/api.md#post-apiauthregister
    func register(email: String, password: String) -> URLRequest {
        let url = baseUrl.appending(path: "/api/auth/register")
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.post
        request.addJsonRequestBody(["email": email, "password": password])
        return request
    }

    // MARK: - POST /api/auth/activate
    // https://github.com/simple-login/app/blob/master/docs/api.md#post-apiauthactivate
    /// Activate a newly registered email
    func activate(email: String, code: String) -> URLRequest {
        let url = baseUrl.appending(path: "/api/auth/activate")
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.post
        request.addJsonRequestBody(["email": email, "code": code])
        return request
    }

    // MARK: - POST /api/auth/reactivate
    // https://github.com/simple-login/app/blob/master/docs/api.md#post-apiauthreactivate
    func reactivate(email: String) -> URLRequest {
        let url = baseUrl.appending(path: "/api/auth/reactivate")
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.post
        request.addJsonRequestBody(["email": email])
        return request
    }

    // MARK: - POST /api/auth/forgot_password
    // https://github.com/simple-login/app/blob/master/docs/api.md#post-apiauthforgot_password
    func forgotPassword(email: String) -> URLRequest {
        let url = baseUrl.appending(path: "/api/auth/forgot_password")
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.post
        request.addJsonRequestBody(["email": email])
        return request
    }

    // MARK: - GET /api/user_info
    // https://github.com/simple-login/app/blob/master/docs/api.md#get-apiuser_info
    func getUserInfo(apiKey: ApiKey) -> URLRequest {
        let url = baseUrl.appending(path: "/api/user_info")
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.get
        request.addApiKeyToHeaders(apiKey)
        return request
    }

    // MARK: - PATCH /api/user_info
    // https://github.com/simple-login/app/blob/master/docs/api.md#patch-apiuser_info
    func updateProfilePicture(apiKey: ApiKey, profilePicture: String?) -> URLRequest {
        let url = baseUrl.appending(path: "/api/user_info")
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.patch
        request.addApiKeyToHeaders(apiKey)
        request.addJsonRequestBody(["profile_picture": profilePicture])
        return request
    }

    func updateProfileName(apiKey: ApiKey, name: String?) -> URLRequest {
        let url = baseUrl.appending(path: "/api/user_info")
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.patch
        request.addApiKeyToHeaders(apiKey)
        request.addJsonRequestBody(["name": name])
        return request
    }
}

// MARK: - Alias
extension Endpoint {
    // MARK: - GET /api/v5/alias/options
    // https://github.com/simple-login/app/blob/master/docs/api.md#get-apiv5aliasoptions
    func getAliasOptions(apiKey: ApiKey, hostname: String?) -> URLRequest {
        let path = "/api/v5/alias/options"
        let url: URL
        if let hostname = hostname {
            url = baseUrl.appending(path: path, queryItems: [.init(name: "hostname", value: hostname)])
        } else {
            url = baseUrl.appending(path: path)
        }
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.get
        request.addApiKeyToHeaders(apiKey)
        return request
    }

    // MARK: - POST /api/v3/alias/custom/new
    // https://github.com/simple-login/app/blob/master/docs/api.md#post-apiv3aliascustomnew
    func createAlias(apiKey: ApiKey, options: AliasCreationOptions) -> URLRequest {
        let url = baseUrl.appending(path: "/api/v3/alias/custom/new", queryItems: options.queryItems())
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.post
        request.addApiKeyToHeaders(apiKey)
        request.addJsonRequestBody(options.requestBody())
        return request
    }

    // MARK: - POST /api/alias/random/new
    // https://github.com/simple-login/app/blob/master/docs/api.md#post-apialiasrandomnew
    func randomAlias(apiKey: ApiKey, options: AliasRandomOptions) -> URLRequest {
        let url = baseUrl.appending(path: "/api/alias/random/new",
                                    queryItems: options.queryItems())
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.post
        request.addApiKeyToHeaders(apiKey)
        request.addJsonRequestBody(options.requestBody())
        return request
    }

    // MARK: - GET /api/v2/aliases
    // https://github.com/simple-login/app/blob/master/docs/api.md#get-apiv2aliases
    func getAliases(apiKey: ApiKey, page: Int) -> URLRequest {
        let url = baseUrl.appending(path: "/api/v2/aliases",
                                    queryItems: [.init(name: "page_id", value: "\(page)")])
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.get
        request.addApiKeyToHeaders(apiKey)
        return request
    }

    // MARK: - GET /api/aliases/:alias_id
    // https://github.com/simple-login/app/blob/master/docs/api.md#get-apialiasesalias_id
    func getAlias(apiKey: ApiKey, id: Int) -> URLRequest {
        let url = baseUrl.appending(path: "/api/aliases/\(id)")
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.get
        request.addApiKeyToHeaders(apiKey)
        return request
    }

    // MARK: - DELETE /api/aliases/:alias_id
    // https://github.com/simple-login/app/blob/master/docs/api.md#delete-apialiasesalias_id
    func deleteAlias(apiKey: ApiKey, id: Int) -> URLRequest {
        let url = baseUrl.appending(path: "/api/aliases/\(id)")
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.delete
        request.addApiKeyToHeaders(apiKey)
        return request
    }

    // MARK: - POST /api/aliases/:alias_id/toggle
    // https://github.com/simple-login/app/blob/master/docs/api.md#post-apialiasesalias_idtoggle
    func toggleAliasStatus(apiKey: ApiKey, id: Int) -> URLRequest {
        let url = baseUrl.appending(path: "/api/aliases/\(id)/toggle")
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.post
        request.addApiKeyToHeaders(apiKey)
        return request
    }

    // MARK: - GET /api/aliases/:alias_id/activities
    // https://github.com/simple-login/app/blob/master/docs/api.md#get-apialiasesalias_idactivities
    func getAliasActivities(apiKey: ApiKey, id: Int, page: Int) -> URLRequest {
        let url = baseUrl.appending(path: "/api/aliases/\(id)/activities",
                                    queryItems: [.init(name: "page_id", value: "\(page)")])
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.get
        request.addApiKeyToHeaders(apiKey)
        return request
    }

    // MARK: - PATCH /api/aliases/:alias_id
    // https://github.com/simple-login/app/blob/master/docs/api.md#patch-apialiasesalias_id
    func updateAlias(apiKey: ApiKey, id: Int, option: AliasUpdateOption) -> URLRequest {
        let url = baseUrl.appending(path: "/api/aliases/\(id)")
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.patch
        request.addApiKeyToHeaders(apiKey)
        request.addJsonRequestBody(option.requestBody)
        return request
    }

    // MARK: - GET /api/aliases/:alias_id/contacts
    // https://github.com/simple-login/app/blob/master/docs/api.md#get-apialiasesalias_idcontacts
    func getAliasContacts(apiKey: ApiKey, id: Int, page: Int) -> URLRequest {
        let url = baseUrl.appending(path: "/api/aliases/\(id)/contacts",
                                    queryItems: [.init(name: "page_id", value: "\(page)")])
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.get
        request.addApiKeyToHeaders(apiKey)
        return request
    }

    // MARK: - POST /api/aliases/:alias_id/contacts
    // https://github.com/simple-login/app/blob/master/docs/api.md#post-apialiasesalias_idcontacts
    func createContact(apiKey: ApiKey, aliasId: Int, contactEmail: String) -> URLRequest {
        let url = baseUrl.appending(path: "/api/aliases/\(aliasId)/contacts")
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.post
        request.addApiKeyToHeaders(apiKey)
        request.addJsonRequestBody(["contact": contactEmail])
        return request
    }
}

// MARK: - Mailbox
extension Endpoint {
    // MARK: - GET /api/v2/mailboxes
    // https://github.com/simple-login/app/blob/master/docs/api.md#get-apiv2mailboxes
    func getMailboxes(apiKey: ApiKey) -> URLRequest {
        let url = baseUrl.appending(path: "/api/v2/mailboxes")
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.get
        request.addApiKeyToHeaders(apiKey)
        return request
    }

    // MARK: - POST /api/mailboxes
    // https://github.com/simple-login/app/blob/master/docs/api.md#post-apimailboxes
    func createMailbox(apiKey: ApiKey, email: String) -> URLRequest {
        let url = baseUrl.appending(path: "/api/mailboxes")
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.post
        request.addApiKeyToHeaders(apiKey)
        request.addJsonRequestBody(["email": email])
        return request
    }

    // MARK: - DELETE /api/mailboxes/:mailbox_id
    // https://github.com/simple-login/app/blob/master/docs/api.md#delete-apimailboxesmailbox_id
    func deleteMailbox(apiKey: ApiKey, id: Int) -> URLRequest {
        let url = baseUrl.appending(path: "/api/mailboxes/\(id)")
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.delete
        request.addApiKeyToHeaders(apiKey)
        return request
    }

    // MARK: - PUT /api/mailboxes/:mailbox_id
    // https://github.com/simple-login/app/blob/master/docs/api.md#put-apimailboxesmailbox_id
    func updateMailbox(apiKey: ApiKey, id: Int, option: MailboxUpdateOption) -> URLRequest {
        let url = baseUrl.appending(path: "/api/mailboxes/\(id)")
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.put
        request.addApiKeyToHeaders(apiKey)
        request.addJsonRequestBody(option.requestBody)
        return request
    }
}

// MARK: - Custom domain
extension Endpoint {
    // MARK: - GET /api/custom_domains
    // https://github.com/simple-login/app/blob/master/docs/api.md#get-apicustom_domains
    func getCustomDomains(apiKey: ApiKey) -> URLRequest {
        let url = baseUrl.appending(path: "/api/custom_domains")
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.get
        request.addApiKeyToHeaders(apiKey)
        return request
    }

    // MARK: - PATCH /api/custom_domains/:custom_domain_id
    // https://github.com/simple-login/app/blob/master/docs/api.md#patch-apicustom_domainscustom_domain_id
    func updateCustomDomain(apiKey: ApiKey, id: Int, option: CustomDomainUpdateOption) -> URLRequest {
        let url = baseUrl.appending(path: "/api/custom_domains/\(id)")
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.patch
        request.addApiKeyToHeaders(apiKey)
        request.addJsonRequestBody(option.requestBody)
        return request
    }

    // MARK: - GET /api/custom_domains/:custom_domain_id/trash
    // https://github.com/simple-login/app/blob/master/docs/api.md#get-apicustom_domainscustom_domain_idtrash
    func getDeletedAliases(apiKey: ApiKey, customDomainId: Int) -> URLRequest {
        let url = baseUrl.appending(path: "/api/custom_domains/\(customDomainId)/trash")
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.get
        request.addApiKeyToHeaders(apiKey)
        return request
    }
}

// MARK: - Contact
extension Endpoint {
    // MARK: - DELETE /api/contacts/:contact_id
    // https://github.com/simple-login/app/blob/master/docs/api.md#delete-apicontactscontact_id
    func deleteContact(apiKey: ApiKey, id: Int) -> URLRequest {
        let url = baseUrl.appending(path: "/api/contacts/\(id)")
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.delete
        request.addApiKeyToHeaders(apiKey)
        return request
    }
}
