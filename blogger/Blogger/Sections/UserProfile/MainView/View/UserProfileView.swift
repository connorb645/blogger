//
//  UserProfileView.swift
//  Blogger
//
//  Created by Connor Black on 30/10/2021.
//

import SwiftUI
import AttributedText

struct UserProfileView<R: UserProfileViewRouterProtocol>: View {
    
    @ObservedObject var viewModel: UserProfileViewModel
    @StateObject var router: R
        
    init(router: R,
         viewModel: UserProfileViewModel) {
        self._router = StateObject(wrappedValue: router)
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        ZStack {
            Colors.background
                .edgesIgnoringSafeArea(.all)
            
            StateSwitcher(state: $viewModel.state)
        }
        .navigation(router)
    }
}

struct UserProfileView_Previews: PreviewProvider {

    static let user = StubGenerator().user
    static let articles = StubGenerator().articles
    
    static var viewModelLoaded: UserProfileViewModel {
        let vm = UserProfileViewModel(user: user)
        let loadedViewModel = UserProfileLoadedViewModel(user: user,
                                                         articles: articles,
                                                         profileImageUrl: "",
                                                         isCurrentUser: false)
        vm.state = .loaded(view: UserProfileLoadedView(viewModel: loadedViewModel))
        return vm
    }
    
    static var viewModelLoading: UserProfileViewModel {
        let vm = UserProfileViewModel(user: user)
        vm.state = .loading
        return vm
    }
    
    static var viewModelError: UserProfileViewModel {
        let vm = UserProfileViewModel(user: user)
        vm.state = .error(error: NetworkError.noData)
        return vm
    }
    
    static let router = UserProfileViewRouter(isPresented: .constant(true))
    
    static var previews: some View {
        
        Group {
            UserProfileView(router: router, viewModel: viewModelLoaded)
            UserProfileView(router: router, viewModel: viewModelLoading)
            UserProfileView(router: router, viewModel: viewModelError)
        }
    }
}
