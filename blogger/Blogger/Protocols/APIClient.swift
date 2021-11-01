//
//  APIClient.swift
//  Blogger
//
//  Created by Connor Black on 12/10/2021.
//

import Foundation
import Promises

protocol APIClient {
    func getAllArticles() -> Promise<[Article]>
    func getArticle(id: UUID) -> Promise<Article>
    func getArticleDocument(id: UUID) -> Promise<String>
    func getUser(id: UUID) -> Promise<User>
    func getCurrentUser() -> Promise<User>
    func getUsersArticles(id: UUID) -> Promise<[Article]>
    func login(emailAddress: String, password: String) -> Promise<AuthenticationResult>
    func signUp(emailAddress: String, password: String) -> Promise<AuthenticationResult>
}
