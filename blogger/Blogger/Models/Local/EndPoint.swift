//
//  EndPoint.swift
//  Blogger
//
//  Created by Connor Black on 15/10/2021.
//

import Foundation

enum EndPoint {
    case articles
    case article(id: UUID)
    case usersArticles(id: UUID)
    case document(id: UUID)
    case login
    case signUp
    case user(id: UUID)
    case currentUser
    
    var path: String {
        switch self {
        case .articles:
            return "/articles"
        case .article(let id):
            return "/articles/\(id)"
        case .usersArticles(let id):
            return "/users/\(id)/articles"
        case .document(let id):
            return "/document/\(id)"
        case .login:
            return "/session/login"
        case .signUp:
            return "/session/signup"
        case .user(let id):
            return "/users/\(id)"
        case .currentUser:
            return "/users/current"
        }
    }
}
