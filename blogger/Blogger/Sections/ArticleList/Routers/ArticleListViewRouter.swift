//
//  ArticleListViewRouter.swift
//  Blogger
//
//  Created by Connor Black on 01/11/2021.
//

import Foundation

protocol ArticleListViewRouterProtocol: Router {
    func showArticleDetail(_ articleAndAuthor: ArticleAndAuthor)
    func presentUserProfile()
}

class ArticleListViewRouter: Router, ArticleListViewRouterProtocol {
    func showArticleDetail(_ articleAndAuthor: ArticleAndAuthor) {
        let router = ArticleDetailViewRouter(isPresented: isPushing)
        let viewModel = ArticleDetailViewModel(articleAndAuthor: articleAndAuthor)
        let view = ArticleDetailView(router: router, viewModel: viewModel)
        push(view)
    }
    
    func presentUserProfile() {
        let router = UserProfileViewRouter(isPresented: isPresenting)
        let viewModel = UserProfileViewModel(user: nil)
        let view = UserProfileView(router: router, viewModel: viewModel)
        present(view, router: router)
    }
}
