//
//  APIClient.swift
//  Blogger
//
//  Created by Connor Black on 12/10/2021.
//

import Foundation
import Promises

struct APIClientService: APIClient {
    
    private let networkingService: NetworkingService
    private let networkingParserService: NetworkingParserService
    private let authSessionService: AuthSessionService
    
    init(networkingService: NetworkingService = NetworkingService(),
         networkingParserService: NetworkingParserService = NetworkingParserService(),
         authSessionService: AuthSessionService = AuthSessionService()) {
        self.networkingService = networkingService
        self.networkingParserService = networkingParserService
        self.authSessionService = authSessionService
    }
    
    func getUser(id: UUID) -> Promise<User> {
        networkingParserService.get(.user(id: id))
    }
    
    func getCurrentUser() -> Promise<User> {
        return Promise { accept, reject in
            if let authToken = authSessionService.authToken {
                accept(authToken)
            } else {
                reject(RoutingError.notLoggedIn)
            }
        }.then { authToken in
            return networkingParserService.get(.currentUser, authType: .bearer(token: authToken))
        }
    }

    func getAllArticles() -> Promise<[Article]> {
        networkingParserService.get(.articles)
    }
    
    func getArticle(id: UUID) -> Promise<Article> {
        return networkingParserService.get(.article(id: id))
    }
    
    func getArticleDocument(id: UUID) -> Promise<String> {
        return networkingService.get(.document(id: id))
            .then { data in
                return String(decoding: data, as: UTF8.self)
            }
    }
    
    func getUsersArticles(id: UUID) -> Promise<[Article]> {
        return networkingParserService.get(.usersArticles(id: id))
    }
    
    func login(emailAddress: String, password: String) -> Promise<AuthenticationResult> {
        networkingParserService.post(.login,
                                     authType: .basic(email: emailAddress,
                                                      password: password))
    }
    
    func signUp(emailAddress: String, password: String) -> Promise<AuthenticationResult> {
        networkingParserService.post(.signUp,
                                     object: SignUpContract(emailAddress: emailAddress,
                                                            password: password))
    }
}
