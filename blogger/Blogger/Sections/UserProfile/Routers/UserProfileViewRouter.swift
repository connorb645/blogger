//
//  UserProfileViewRouter.swift
//  Blogger
//
//  Created by Connor Black on 01/11/2021.
//

import Foundation
import SwiftUI

protocol UserProfileViewRouterProtocol: Router {
    func presentFakeView()
}

class UserProfileViewRouter: Router, UserProfileViewRouterProtocol {
    func presentFakeView() {
        let view = Text("Blashhhhhhh")
        push(view)
    }
}
