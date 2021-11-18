//
//  AuthenticationDetails.swift
//  Blogger
//
//  Created by Connor Black on 13/11/2021.
//

import Foundation

struct AuthenticationDetails: Codable {
    let authToken: String
    let refreshToken: String
    let authTokenExpiry: Date
}
