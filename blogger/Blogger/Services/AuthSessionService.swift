//
//  AuthSessionService.swift
//  Blogger
//
//  Created by Connor Black on 27/10/2021.
//

import Foundation

class AuthSessionService {
    
    private let userDefaults: UserDefaults
    
    private let authDetailsKey = UserDefaultsKey.authDetails.rawValue
        
    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
    
    var authDetails: AuthenticationDetails? {
        set {
            do {
                try userDefaults.setObject(newValue, forKey: authDetailsKey)
            } catch (let e) {
                print(e.localizedDescription)
            }
        }
        get {
            do {
                let authDetail = try userDefaults.getObject(forKey: authDetailsKey, castTo: AuthenticationDetails.self)
                return authDetail
            } catch (let e) {
                print(e.localizedDescription)
                return nil
            }
        }
    }
    
    func removeAuthDetails() {
        authDetails = nil
    }
}
