//
//  HomeView.swift
//  Blogger
//
//  Created by Connor Black on 27/10/2021.
//

import SwiftUI

struct ArticleListView<R: ArticleListViewRouterProtocol>: View {
    @ObservedObject var viewModel: ArticleListViewModel
    @StateObject private var router: R
    
    init(router: R, viewModel: ArticleListViewModel) {
        self.viewModel = viewModel
        self._router = StateObject(wrappedValue: router)
    }
    
    var body: some View {
        List {
            ForEach(viewModel.articles, id: \.self) { articleAndAuthor in
                
                Button {
                    router.showArticleDetail(articleAndAuthor)
                } label: {
                    ListItemView(heading: articleAndAuthor.article.title,
                                 subHeading: articleAndAuthor.author.fullName)
                }

            }
        }
        .toolbar {
            Button {
                router.presentUserProfile()
            } label: {
                Image(systemName: "person")
                    .foregroundColor(.black)
            }
        }
        .navigation(router)
        .sheet(router)
        .navigationTitle("All Articles")
    }
}
