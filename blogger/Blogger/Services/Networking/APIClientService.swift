//
//  APIClient.swift
//  Blogger
//
//  Created by Connor Black on 12/10/2021.
//

import Foundation
import UIKit

struct APIClientService: UserAPIClient,
                         ArticleAPIClient,
                         SessionAPIClient,
                         UtilAPIClient,
                         TrueDateAPIClient,
                         FileAPIClient {
    

    private let networkingService: NetworkingService
    private let networkingParserService: NetworkingParserService
    private let authService: AuthSessionService
    
    init(networkingService: NetworkingService = NetworkingService(),
         networkingParserService: NetworkingParserService = NetworkingParserService(),
         authService: AuthSessionService = AuthSessionService()) {
        self.networkingService = networkingService
        self.networkingParserService = networkingParserService
        self.authService = authService
    }
    
    func user(id: UUID) async throws -> User? {
        try await networkingParserService.get(.user(id: id))
    }

    func currentUser() async throws -> User? {
        guard let authDetails = authService.authDetails else {
            throw RoutingError.notLoggedIn
        }
        
        return try await networkingParserService.get(.currentUser, authType: .bearer(token: authDetails.authToken))
    }
    
    var isAuthenticated: Bool {
        get async throws {
            guard let authDetails = authService.authDetails else {
                return false
            }

            let date = try await currentDate()?.current ?? Date()

            return date < authDetails.authTokenExpiry
        }
    }

    func allArticles() async throws -> [Article]? {
        try await networkingParserService.get(.articles)
    }
    
    func article(id: UUID) async throws -> Article? {
        try await networkingParserService.get(.article(id: id))
    }

    func articlesAndAuthors() async throws -> [ArticleAndAuthor]? {
        let articles = try await allArticles()
        return try await articlesAndAuthors(for: articles)
    }
    
    func articlesAndAuthors(for articles: [Article]?) async throws -> [ArticleAndAuthor]? {
        var articlesAndAuthors = [ArticleAndAuthor?]()
        try await withThrowingTaskGroup(of: ArticleAndAuthor?.self) { group in
            for article in articles ?? []{
                group.addTask {
                    guard let author = try await user(id: article.authorId) else {
                        return nil
                    }
                    return ArticleAndAuthor(article: article, author: author)
                }
            }
            
            for try await articleAndAuthor in group {
                articlesAndAuthors.append(articleAndAuthor)
            }
        }
        return articlesAndAuthors.compactMap { $0 }
    }
    
    func authors(for articles: [Article]?) async throws -> [User]? {
        let articlesAndAuthors = try await articlesAndAuthors(for: articles) ?? []
        return articlesAndAuthors.map { $0.author }
    }
    
    func usersArticles(id: UUID) async throws -> [Article]? {
        try await networkingParserService.get(.usersArticles(id: id))
    }
    
    func login(emailAddress: String, password: String) async throws -> AuthenticationResult? {
        try await networkingParserService.post(.login,
                                     authType: .basic(email: emailAddress,
                                                      password: password))
    }
    
    func signUp(emailAddress: String, password: String) async throws -> AuthenticationResult? {
        try await networkingParserService.post(.signUp,
                                     object: SignUpContract(emailAddress: emailAddress,
                                                            password: password))
    }
    
    func downloadUrl(for contentKey: String) async throws -> String? {
        guard let data = try await networkingService.get(.file(key: contentKey)) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func currentDate() async throws -> TrueDate? {
        try await networkingParserService.get(.currentDate)
    }
}
