//
//  CoordinatorView.swift
//  Blogger
//
//  Created by Connor Black on 29/10/2021.
//

import SwiftUI

struct RootView: View {
        
    var body: some View {
        NavigationView {
            ArticleListView(router: ArticleListViewRouter(isPresented: .constant(false)),
                            viewModel: .init())
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
