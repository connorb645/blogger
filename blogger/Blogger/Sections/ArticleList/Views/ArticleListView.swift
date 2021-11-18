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
        VStack {
            List {
                ForEach(viewModel.articlesAndAuthors, id: \.self) { articleAndAuthor in
                    
                    Button {
                        router.showArticleDetail(articleAndAuthor)
                    } label: {
                        ListItemView(heading: articleAndAuthor.article.title,
                                     subHeading: articleAndAuthor.author.fullName)
                            .foregroundColor(.black)
                    }

                }
            }.frame(maxHeight: .infinity)
            
            Button {
                router.presentDiagnostics()
            } label: {
                CBText(text: Bundle.main.releaseVersionNumber ?? "", textType: .subHeading, alignment: .center)
            }
            
            .toolbar {
                Button {
                    Task {
                        router.presentUserProfileOrLogin(isAuthenticated: await viewModel.isAuthenticated)
                    }
                } label: {
                    Image(systemName: "person")
                        .foregroundColor(.black)
                }
            }
            
            .navigationTitle("All Articles")

        }
        .navigation(router)
        .sheet(router)
        
    }
}
