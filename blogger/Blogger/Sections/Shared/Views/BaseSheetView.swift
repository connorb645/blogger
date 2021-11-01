//
//  SheetNavigationLink.swift
//  Blogger
//
//  Created by Connor Black on 30/10/2021.
//

import SwiftUI

struct BaseSheetView<Content: View>: View {
    
    let router: Router
    @ViewBuilder var content: Content
    
    var body: some View {
        NavigationView {
            content
                .toolbar {
                    Button {
                        router.dismiss()
                    } label: {
                        Image(systemName: "multiply")
                            .renderingMode(.original)
                            .foregroundColor(.black)
                    }
                }
        }
    }
}
