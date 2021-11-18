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
    case login
    case signUp
    case user(id: UUID)
    case currentUser
    case file(key: String)
    case currentDate
    
    var path: String {
        switch self {
        case .articles:
            return "/articles"
        case .article(let id):
            return "/articles/\(id)"
        case .usersArticles(let id):
            return "/users/\(id)/articles"
        case .login:
            return "/session/login"
        case .signUp:
            return "/session/signup"
        case .user(let id):
            return "/users/\(id)"
        case .currentUser:
            return "/users/current"
        case .file(let key):
            return "/files/\(key)"
        case .currentDate:
            return "/session/current-date"
        }
    }
}
