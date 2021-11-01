//
//  CoordinatorViewModel.swift
//  Blogger
//
//  Created by Connor Black on 29/10/2021.
//

import Foundation
import SwiftUI

//enum Page {
//    case articleList
//    case articleDetail(articleAndAuthor: ArticleAndAuthor)
//    case userProfile
//    case login
//}
//
//final class Coordinator {
//    
//    private let authService: AuthSessionService
//    
//    init(authService: AuthSessionService = AuthSessionService()) {
//        self.authService = authService
//    }
//    
//    func new(_ page: Page, isPresented: Binding<Bool>?) -> AnyView {
//        switch page {
//        case .articleList:
//            return configureArticleList()
//        case .articleDetail(let articleAndAuthor):
//            return configureArticleDetailView(with: articleAndAuthor)
//        case .userProfile:
//            return configureUserProfileView(isPresented: isPresented)
//        case .login:
//            return configureLoginView()
//        }
//    }
//    
//    private func configureArticleList() -> AnyView {
//        let viewModel = ArticleListViewModel(coordinator: self)
//        return wrap(ArticleListView(viewModel: viewModel))
//    }
//    
//    private func configureArticleDetailView(with articleAndAuthor: ArticleAndAuthor) -> AnyView {
//        let viewModel = ArticleDetailViewModel(coordinator: self, articleAndAuthor: articleAndAuthor)
//        return wrap(ArticleDetailView(viewModel: viewModel))
//    }
//    
//    private func configureUserProfileView(isPresented: Binding<Bool>?) -> AnyView {
//        
//        if let isPresented = isPresented, authService.isAuthenticated {
//            let viewModel = UserProfileViewModel(coordinator: self, user: nil, isPresented: isPresented)
//            viewModel.isPresented = isPresented
//            return wrap(UserProfileView(viewModel: viewModel))
//        }
//        
//        return configureLoginView()
//    }
//    
//    private func configureLoginView() -> AnyView {
//        let viewModel = LoginViewModel(coordinator: self)
//        return wrap(LoginView(viewModel: viewModel))
//    }
//    
//    private func wrap<Content: View>(_ content: Content) -> AnyView {
//        return AnyView(content)
//    }
//    
//}
