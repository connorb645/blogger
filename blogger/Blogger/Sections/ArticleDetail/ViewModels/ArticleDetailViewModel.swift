//
//  ArticleDetailViewModel.swift
//  Blogger
//
//  Created by Connor Black on 29/10/2021.
//

import Foundation
import MarkdownUI

final class ArticleDetailViewModel: ObservableObject {
    
    private let apiClient: APIClient
    
    @Published var articleAndAuthor: ArticleAndAuthor
    @Published var markdown: Document?
    
    init(articleAndAuthor: ArticleAndAuthor,
         apiClient: APIClient = APIClientService()) {
        self.articleAndAuthor = articleAndAuthor
        self.apiClient = apiClient
        
        loadData()
    }
    
    private func loadData() {
        apiClient.getArticleDocument(id: articleAndAuthor.article.contentId)
            .then { markdownString in
                self.markdown = Document(stringLiteral: markdownString)
            }
            .catch { error in
                print(error)
            }
    }
}
