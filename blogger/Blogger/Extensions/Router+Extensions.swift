//
//  Router+Extensions.swift
//  Blogger
//
//  Created by Connor Black on 01/11/2021.
//

import Foundation
import SwiftUI

extension Router {
    
    func push<V: View>(_ view: V) {
        state.navigating = AnyView(view)
    }
    
    func present<V: View>(_ view: V, router: Router) {
        state.presentingSheet = AnyView(BaseSheetView(router: router) {view})
    }
    
    func dismiss() {
        state.isPresented.wrappedValue = false
    }
    
    var isPushing: Binding<Bool> {
        boolBinding(keyPath: \.navigating)
    }
    
    var isPresenting: Binding<Bool> {
        boolBinding(keyPath: \.presentingSheet)
    }
    
    var isPresented: Binding<Bool> {
        state.isPresented
    }
    
    func binding<T>(keyPath: WritableKeyPath<State, T>) -> Binding<T> {
        Binding(
            get: { self.state[keyPath: keyPath] },
            set: { self.state[keyPath: keyPath] = $0 }
        )
    }
    
    func boolBinding<T>(keyPath: WritableKeyPath<State, T?>) -> Binding<Bool> {
        Binding(
            get: { self.state[keyPath: keyPath] != nil },
            set: {
                if !$0 {
                    self.state[keyPath: keyPath] = nil
                }
            }
        )
    }
}
