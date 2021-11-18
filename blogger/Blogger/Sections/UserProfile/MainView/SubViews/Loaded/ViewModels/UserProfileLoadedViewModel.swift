//
//  UserProfileLoadedViewModel.swift
//  Blogger
//
//  Created by Connor Black on 05/11/2021.
//

import Foundation
import UIKit

class UserProfileLoadedViewModel: ObservableObject {
    let user: User
    let articles: [Article]
    let profileImageUrl: String?
    let isCurrentUser: Bool
    private let authService: AuthSessionService
    
    init(user: User,
         articles: [Article],
         profileImageUrl: String?,
         isCurrentUser: Bool,
         authService: AuthSessionService = AuthSessionService()) {
        self.user = user
        self.articles = articles
        self.profileImageUrl = profileImageUrl
        self.isCurrentUser = isCurrentUser
        self.authService = authService
    }
    
    var currentAuthToken: String? {
        get  {
            authService.authDetails?.authToken
        }
    }
}
