//
//  NetworkError.swift
//  Blogger
//
//  Created by Connor Black on 15/10/2021.
//

import Foundation

enum NetworkError: Error, Equatable {
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.urlParse, .urlParse):
            return true
        case (.httpUrlResponseParse, .httpUrlResponseParse):
            return true
        case (.badStatusCode(let lCode), .badStatusCode(let rCode)):
            return lCode == rCode
        case (.noData, .noData):
            return true
        case (.parameterDecoding(let lError), .parameterDecoding(let rError)):
            return String(reflecting: lError) == String(reflecting: rError)
        default:
            return false
        }
    }
    
    case urlParse
    case httpUrlResponseParse
    case badStatusCode(code: Int)
    case noData
    case parameterDecoding(error: Error)
}
