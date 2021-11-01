//
//  LoginViewModel.swift
//  Blogger
//
//  Created by Connor Black on 26/10/2021.
//

import Foundation
import Promises

class LoginViewModel: ObservableObject {
    
    var authService: AuthSessionService
    private let apiClient: APIClient
    
    @Published var emailAddressText: String = ""
    @Published var passwordText: String = ""
    
    init(authService: AuthSessionService = AuthSessionService(),
         apiClient: APIClient = APIClientService()) {
        self.authService = authService
        self.apiClient = apiClient
    }
    
    func login() {
        apiClient.login(emailAddress: emailAddressText.lowercased(), password: passwordText)
            .then { authResult in
                self.authService.authToken = authResult.token
                print("Figure out how to dismiss with my new navigation")
            }.catch { error in
                print(error)
            }
    }
}
