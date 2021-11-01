//
//  HomeViewModel.swift
//  Blogger
//
//  Created by Connor Black on 27/10/2021.
//

import Foundation
import Promises
import SwiftUI

final class ArticleListViewModel: ObservableObject {
    
    private let apiClient: APIClient
    
    @Published var articles: [ArticleAndAuthor] = []
    @Published var presentingUserProfile = false
    
    init(apiClient: APIClient = APIClientService()) {
        self.apiClient = apiClient
        fetchArticles()
    }
    
    private func fetchArticles() {
        apiClient.getAllArticles()
            .then { self.fetchAuthors(for: $0) }
            .then { articlesAndAuthors in
                self.articles = articlesAndAuthors
            }
            .catch { error in
                print(error.localizedDescription)
            }
    }
    
    private func fetchAuthors(for articles: [Article]) -> Promise<[ArticleAndAuthor]> {
        return all(articles.map { article in
            self.apiClient.getUser(id: article.authorId)
                .then { author in
                    return ArticleAndAuthor(article: article, author: author)
                }
        })
    }
    
}
