//
//  SignupResult.swift
//  Blogger
//
//  Created by Connor Black on 26/10/2021.
//

import Foundation

struct AuthenticationResult: Codable {
    let accessToken: String
    let refreshToken: String
    let accessTokenExpiry: Date
    let user: User
}
