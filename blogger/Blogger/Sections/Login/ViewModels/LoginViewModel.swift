//
//  LoginViewModel.swift
//  Blogger
//
//  Created by Connor Black on 26/10/2021.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    var authService: AuthSessionService
    private let sessionAPIClient: SessionAPIClient
    
    @Published var emailAddressText: String = ""
    @Published var passwordText: String = ""
    
    init(authService: AuthSessionService = AuthSessionService(),
         sessionAPIClient: SessionAPIClient = APIClientService()) {
        self.authService = authService
        self.sessionAPIClient = sessionAPIClient
    }
    
    func login() async -> Bool {
        do {
            let authResult = try await sessionAPIClient.login(emailAddress: emailAddressText.lowercased(),
                                                       password: passwordText)
            
            guard let accessToken = authResult?.accessToken,
                  let refreshToken = authResult?.refreshToken,
                  let accessTokenExpiry = authResult?.accessTokenExpiry else {
                return false
            }
            
            let authDetails = AuthenticationDetails(authToken: accessToken,
                                                    refreshToken: refreshToken,
                                                    authTokenExpiry: accessTokenExpiry)
            authService.authDetails = authDetails
            
            return true
        } catch(let error) {
            print(error.localizedDescription)
            return false
        }
    }
}
