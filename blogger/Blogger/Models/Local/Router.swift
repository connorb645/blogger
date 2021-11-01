//
//  Router.swift
//  Blogger
//
//  Created by Connor Black on 01/11/2021.
//

import Foundation
import SwiftUI

class Router: ObservableObject {
    
    struct State {
        var navigating: AnyView? = nil
        var presentingSheet: AnyView? = nil
        var isPresented: Binding<Bool>
    }
    
    @Published var state: State
    
    init(isPresented: Binding<Bool>) {
        state = State(isPresented: isPresented)
    }
}
