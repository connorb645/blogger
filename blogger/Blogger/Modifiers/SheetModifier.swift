//
//  SheetModifier.swift
//  Blogger
//
//  Created by Connor Black on 01/11/2021.
//

import Foundation
import SwiftUI

struct SheetModifier: ViewModifier {
    
    @Binding var presentingView: AnyView?
    
    var isActive: Binding<Bool> {
        Binding {
            self.presentingView != nil
        } set: {
            if !$0 {
                self.presentingView = nil
            }
        }
    }
    
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: isActive) {
                self.presentingView
            }
    }
}
