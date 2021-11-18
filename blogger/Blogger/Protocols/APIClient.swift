//
//  APIClient.swift
//  Blogger
//
//  Created by Connor Black on 12/10/2021.
//

import Foundation
import UIKit

protocol UserAPIClient {
    func user(id: UUID) async throws -> User?
    func currentUser() async throws -> User?
}

protocol ArticleAPIClient {
    func allArticles() async throws -> [Article]?
    func usersArticles(id: UUID) async throws -> [Article]?
    func article(id: UUID) async throws -> Article?
    func articlesAndAuthors() async throws -> [ArticleAndAuthor]?
    func articlesAndAuthors(for articles: [Article]?) async throws -> [ArticleAndAuthor]?
    func authors(for articles: [Article]?) async throws -> [User]?
}

protocol SessionAPIClient {
    var isAuthenticated: Bool { get async throws }
    func currentUser() async throws -> User?
    func login(emailAddress: String, password: String) async throws -> AuthenticationResult?
    func signUp(emailAddress: String, password: String) async throws -> AuthenticationResult?
}

protocol UtilAPIClient {
    func currentDate() async throws -> TrueDate?
    func downloadUrl(for contentKey: String) async throws -> String?
}

protocol TrueDateAPIClient {
    func currentDate() async throws -> TrueDate?
}

protocol FileAPIClient {
    func downloadUrl(for contentKey: String) async throws -> String?
}
