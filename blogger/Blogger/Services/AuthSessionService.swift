//
//  AuthSessionService.swift
//  Blogger
//
//  Created by Connor Black on 27/10/2021.
//

import Foundation

struct AuthSessionService {
    
    private let userDefaults: UserDefaults
    
    private let authTokenKey = UserDefaultsKey.authToken.rawValue
        
    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
    
    var isAuthenticated: Bool {
        return authToken != nil
    }
    
    var authToken: String? {
        get {
            return userDefaults.string(forKey: authTokenKey)
        }
        set {
            userDefaults.set(newValue, forKey: authTokenKey)
        }
    }
    
    func removeAuthToken() {
        userDefaults.removeObject(forKey: authTokenKey)
    }
}
