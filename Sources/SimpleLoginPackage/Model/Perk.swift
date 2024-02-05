//
// Perk.swift
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

public enum PremiumPerk: CaseIterable {
    case unlimitedAliases
    case unlimitedCustomDomains
    case catchAllDomain
    case sendEmails
    case subdomains
    case directories
    case unlimitedMailboxes
    case pgpEncryption
}

public extension PremiumPerk {
    var title: String {
        switch self {
        case .unlimitedAliases:
            "Unlimited aliases"
        case .unlimitedCustomDomains:
            "Unlimited custom domains"
        case .catchAllDomain:
            "Catch-all (or wildcard) domain"
        case .sendEmails:
            "Initiate a new email from your alias"
        case .subdomains:
            "5 subdomains"
        case .directories:
            "50 directories/usernames"
        case .unlimitedMailboxes:
            "Unlimited mailboxes"
        case .pgpEncryption:
            "PGP encryption"
        }
    }

    var description: String? {
        switch self {
        case .unlimitedCustomDomains:
            "Bring your own domain to create aliases like contact@your-domain.com"
        case .sendEmails:
            "You can create a reverse-alias to send an email to a new contact."
        default:
            nil
        }
    }
}
