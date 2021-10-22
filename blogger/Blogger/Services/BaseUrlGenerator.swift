//
//  BaseUrlGenerator.swift
//  Blogger
//
//  Created by Connor Black on 22/10/2021.
//

import Foundation

struct BaseUrlGenerator {
    
    public var baseUrl: String {
        #if DEBUG
        return "https://blogger-cloud-dev.herokuapp.com/api"
        #else
        return "https://blogger-cloud.herokuapp.com/api"
        #endif
    }
    
}
