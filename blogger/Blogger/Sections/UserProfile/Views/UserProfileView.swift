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
        Button {
            router.presentFakeView()
        } label: {
            Text("Next")
        }
        .navigation(router)
    }
}
