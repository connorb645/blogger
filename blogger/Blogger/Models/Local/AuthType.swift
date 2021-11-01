//
//  AuthType.swift
//  Blogger
//
//  Created by Connor Black on 26/10/2021.
//

import Foundation

enum AuthType {
    case bearer(token: String)
    case basic(email: String, password: String)
    
    var header: String {
        return "Authorization"
    }
    
    var value: String {
        switch self {
        case .bearer(let token):
            return "Bearer \(token)"
        case .basic(let email, let password):
            let loginString = String(format: "%@:%@", email, password)
            let loginData = loginString.data(using: String.Encoding.utf8)!
            let base64LoginString = loginData.base64EncodedString()
            return "Basic \(base64LoginString)"
        }
    }
}
