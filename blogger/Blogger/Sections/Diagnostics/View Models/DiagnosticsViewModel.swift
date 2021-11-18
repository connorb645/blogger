//
//  DiagnosticsViewModel.swift
//  Blogger
//
//  Created by Connor Black on 13/11/2021.
//

import Foundation

class DiagnosticsViewModel: ObservableObject {
    
    private let authService: AuthSessionService
    
    init(authService: AuthSessionService = AuthSessionService()) {
        self.authService = authService
    }
    
    func removeAuthDetails() {
        authService.removeAuthDetails()
    }
    
}
