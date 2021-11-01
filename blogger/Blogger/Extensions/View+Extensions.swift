//
//  View+Extensions.swift
//  Blogger
//
//  Created by Connor Black on 29/10/2021.
//

import Foundation
import SwiftUI

extension View {
    
    func navigation(_ router: Router) -> some View {
        self.modifier(NavigationModifier(presentingView: router.binding(keyPath: \.navigating)))
    }
    
    func sheet(_ router: Router) -> some View {
        self.modifier(SheetModifier(presentingView: router.binding(keyPath: \.presentingSheet)))
    }

}
