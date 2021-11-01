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
        case (.httpUrlResponseParse, .httpUrlResponseParse):
            return true
        case (.badStatusCode(let lCode), .badStatusCode(let rCode)):
            return lCode == rCode
        case (.noData, .noData):
            return true
        default:
            return false
        }
    }
    
    case httpUrlResponseParse
    case badStatusCode(code: Int)
    case noData
}
