//
//  ArticleDetailViewModel.swift
//  Blogger
//
//  Created by Connor Black on 29/10/2021.
//

import Foundation
import MarkdownUI

final class ArticleDetailViewModel: ObservableObject {
    
    private let articleAPIClient: ArticleAPIClient
    private let fileAPIClient: FileAPIClient
    
    @Published var articleAndAuthor: ArticleAndAuthor
    @Published var markdown: Document?
    
    init(articleAndAuthor: ArticleAndAuthor,
         articleAPIClient: ArticleAPIClient = APIClientService(),
         fileAPIClient: FileAPIClient = APIClientService()) {
        self.articleAndAuthor = articleAndAuthor
        self.articleAPIClient = articleAPIClient
        self.fileAPIClient = fileAPIClient
        
        Task {
            await loadData()
        }
    }
    
    private func loadData() async {
        do {
            let fileDownloadUrl = try await fileAPIClient.downloadUrl(for: articleAndAuthor.article.contentKey)
            #warning("We need a helper to download markdown!")
            markdown = Document(stringLiteral: markdownString)
        } catch (let error) {
            print(error.localizedDescription)
        }
    }
}
