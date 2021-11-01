//
//  SignupResult.swift
//  Blogger
//
//  Created by Connor Black on 26/10/2021.
//

import Foundation

struct AuthenticationResult: Codable {
    let token: String
    let user: User
}
