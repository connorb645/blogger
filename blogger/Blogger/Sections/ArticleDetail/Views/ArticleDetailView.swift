//
//  ArticleDetailView.swift
//  Blogger
//
//  Created by Connor Black on 29/10/2021.
//

import SwiftUI
import MarkdownUI

struct ArticleDetailView<R: ArticleDetailViewRouterProtocol>: View {
    
    @ObservedObject private var viewModel: ArticleDetailViewModel
    @StateObject private var router: R
    
    init(router: R,
         viewModel: ArticleDetailViewModel) {
        self._router = StateObject(wrappedValue: router)
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            VStack {
                if let markdown = viewModel.markdown {
                    Markdown(markdown)
                } else {
                    Text("Loading")
                }
            }
            .padding()
            
            .navigationTitle(viewModel.articleAndAuthor.article.title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ArticleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let stub = StubGenerator().articleAndAuthor
        let viewModel = ArticleDetailViewModel(articleAndAuthor: stub)
        let router = ArticleDetailViewRouter(isPresented: .constant(true))
        ArticleDetailView(router: router, viewModel: viewModel)
    }
}
