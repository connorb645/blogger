//
//  RequestBuilderError.swift
//  Blogger
//
//  Created by Connor Black on 22/10/2021.
//

import Foundation

enum RequestBuilderError: Error, Equatable {
    
    static func == (lhs: RequestBuilderError, rhs: RequestBuilderError) -> Bool {
        switch (lhs, rhs) {
        case (.urlParse, .urlParse):
            return true
        case (.parameterDecoding(let lError), .parameterDecoding(let rError)):
            return String(reflecting: lError) == String(reflecting: rError)
        default:
            return false
        }
    }
    
    case urlParse
    case parameterDecoding(error: Error)
}
