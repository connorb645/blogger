//
//  JsonDecoderError.swift
//  Blogger
//
//  Created by Connor Black on 14/10/2021.
//

import Foundation

enum JsonSerializerError: Error, Equatable {
    
    case decodingFailed(error: Error?)
    case encodingFailed(error: Error?)
    case jsonRepresentationFailed(error: Error?)
    
    static func == (lhs: JsonSerializerError, rhs: JsonSerializerError) -> Bool {
        switch (lhs, rhs) {
        case (.decodingFailed(_), .decodingFailed(_)):
            return true
        case (.encodingFailed(_), .encodingFailed(_)):
            return true
        case (.jsonRepresentationFailed(_), .jsonRepresentationFailed(_)):
            return true
        default:
            return false
        }
    }
}
