//
//  HomeViewModel.swift
//  Blogger
//
//  Created by Connor Black on 27/10/2021.
//

import Foundation
import SwiftUI

final class ArticleListViewModel: ObservableObject {
    
    private let articleAPIClient: ArticleAPIClient
    private let sessionAPIClient: SessionAPIClient
    
    @Published var articlesAndAuthors: [ArticleAndAuthor] = []
    
    init(articleAPIClient: ArticleAPIClient = APIClientService(),
         sessionAPIClient: SessionAPIClient = APIClientService()) {
        self.articleAPIClient = articleAPIClient
        self.sessionAPIClient = sessionAPIClient
        
        Task {
            await fetchArticles()
        }
    }
    
    private func fetchArticles() async {
        do {
            
            let articlesAndAuthors = try await articleAPIClient.articlesAndAuthors()
            DispatchQueue.main.async {
                self.articlesAndAuthors = articlesAndAuthors ?? []
            }
        } catch (let error) {
            print(error.localizedDescription)
        }
    }
    
    var isAuthenticated: Bool {
        get async {
            do {
                let isAuthenticated = try await sessionAPIClient.isAuthenticated
                return isAuthenticated
            } catch (let error) {
                print(error.localizedDescription)
                return false
            }
        }
    }
    
}
