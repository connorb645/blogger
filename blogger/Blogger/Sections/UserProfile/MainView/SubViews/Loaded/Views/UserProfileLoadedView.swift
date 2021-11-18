//
//  UserProfileLoadedView.swift
//  Blogger
//
//  Created by Connor Black on 05/11/2021.
//

import SwiftUI

// If current user
#warning("TODO Read/Write list of hashtag groups")
#warning("TODO Read/Write custom links")

// Any user profile
#warning("TODO List to list of users articles")
#warning("TODO Users display name")
#warning("TODO Users profile picture")
#warning("TODO Read only custom links")

struct UserProfileLoadedView: View {
    
    let viewModel: UserProfileLoadedViewModel
    
    var body: some View {
        ScrollView {

            VStack {
                ProfileHeaderView(profileImageUrl: viewModel.profileImageUrl,
                                  title: viewModel.user.fullName,
                                  subTitle: "iOS Developer",
                                  editable: viewModel.isCurrentUser)
                    .padding()
                
                if viewModel.isCurrentUser {
                    AuthTokenView(token: "iuhg807hgo8w4hg8ouruhoer8yg84g")
                }                

            }
            .padding()
            
        }
    }
}

struct UserProfileLoadedView_Previews: PreviewProvider {
    static var previews: some View {
        let user = StubGenerator().user
        let article = StubGenerator().article
        let articles = [article, article, article, article, article]
        let viewModel = UserProfileLoadedViewModel(user: user,
                                                   articles: articles,
                                                   profileImageUrl: "",
                                                   isCurrentUser: true)
        UserProfileLoadedView(viewModel: viewModel)
    }
}
