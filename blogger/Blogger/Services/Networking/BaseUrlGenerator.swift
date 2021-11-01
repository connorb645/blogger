//
//  BaseUrlGenerator.swift
//  Blogger
//
//  Created by Connor Black on 22/10/2021.
//

import Foundation

struct BaseUrlGenerator {
    
    let usingLocalServer = true
    
    public var baseUrl: String {
        
        #if RELEASE
        return "https://blogger-cloud.herokuapp.com/api"
        #endif
        
        if usingLocalServer {
            return "http://127.0.0.1:8080/api"
        } else {
            return "https://blogger-cloud-dev.herokuapp.com/api"
        }
    }
    
}
