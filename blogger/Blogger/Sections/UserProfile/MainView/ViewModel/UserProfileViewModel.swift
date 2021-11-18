//
//  UserProfileViewModel.swift
//  Blogger
//
//  Created by Connor Black on 30/10/2021.
//

import Foundation
import SwiftUI

final class UserProfileViewModel: ObservableObject {
    
    let userAPIClient: UserAPIClient
    let articleAPIClient: ArticleAPIClient
    let utilAPIClient: UtilAPIClient
    
    let isCurrentUsersProfile: Bool
        
    @Published var state: ViewState<UserProfileLoadedView> = .loading
    
    init(user: User?,
         userAPIClient: UserAPIClient = APIClientService(),
         articleAPIClient: ArticleAPIClient = APIClientService(),
         utilAPIClient: UtilAPIClient = APIClientService()) {
        
        self.userAPIClient = userAPIClient
        self.articleAPIClient = articleAPIClient
        self.utilAPIClient = utilAPIClient
        
        self.isCurrentUsersProfile = user == nil
        
        Task {
            await performFetchOperations(with: user)
        }
    }
    
    private func performFetchOperations(with defaultUser: User?) async {
        do {
            let user = try await unwrapOrFetchCurrentUser(defaultUser)
            let articles = try await articleAPIClient.usersArticles(id: user.id)
            let profileImageUrl = try await utilAPIClient.downloadUrl(for: user.profilePictureKey)
            let loadedViewModel = UserProfileLoadedViewModel(user: user,
                                                             articles: articles ?? [],
                                                             profileImageUrl: profileImageUrl,
                                                             isCurrentUser: isCurrentUsersProfile)
            let loadedView = UserProfileLoadedView(viewModel: loadedViewModel)
            
            DispatchQueue.main.async {
                self.state = .loaded(view: loadedView)
            }
            
        } catch(let error) {
            print(error)
            print(error.localizedDescription)
            DispatchQueue.main.async {
                self.state = .error(error: error)
            }
        }
    }
    
    private func unwrapOrFetchCurrentUser(_ user: User?) async throws -> User {
        var user: User!
        if let defaultUser = user {
            user = defaultUser
        } else {
            user = try await currentUser
        }
        return user
    }
    
    private var currentUser: User? {
        get async throws {
            try await userAPIClient.currentUser()
        }
    }
}
