//
//  UserProfileViewModel.swift
//  Blogger
//
//  Created by Connor Black on 30/10/2021.
//

import Foundation
import Promises
import SwiftUI

final class UserProfileViewModel: ObservableObject {
    
    let apiClient: APIClient
    
    let isCurrentUsersProfile: Bool
        
    @Published var user: User?
    @Published var articles: [Article] = []
    
    init(user: User?,
         apiClient: APIClient = APIClientService()) {
        
        self.apiClient = apiClient
        self.user = user
        self.isCurrentUsersProfile = user == nil
        
        performFetchOperations()
    }
    
    private func performFetchOperations() {
        fetchCorrectUser.then {
            self.fetchUsersArticles(user: $0)
        }.then {
            self.user = $0.0
            self.articles = $0.1
        }
        .catch { error in
            print(error.localizedDescription)
        }
    }
    
    private var fetchCorrectUser: Promise<User> {
        if let user = user {
            return Promise(user)
        } else {
            return apiClient.getCurrentUser()
        }
    }
    
    private func fetchUsersArticles(user: User) -> Promise<(User, [Article])> {
        return apiClient.getAllArticles()
            .then { articles in
                return (user, articles)
            }
    }
}
