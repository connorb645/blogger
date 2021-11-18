//
//  StateSwitcher.swift
//  Blogger
//
//  Created by Connor Black on 07/11/2021.
//

import SwiftUI

struct StateSwitcher<Content: View>: View {
    
    @Binding var state: ViewState<Content>
    
    var body: some View {
        #warning("I haven't build the loading and error views.")
        Group {
            switch state {
            case .loading:
                Text("Some generic loading view")
            case .loaded(let view):
                view
            case .error(let error):
                Text("Some generic error: \(error.localizedDescription)")
            }
        }
    }
}
