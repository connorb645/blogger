//
//  MockGenericJsonResponse.swift
//  BloggerTests
//
//  Created by Connor Black on 15/10/2021.
//

import Foundation

struct MockGenericJsonResponse: Codable {
    let stringValue: String
    let intValue: Int
    let boolValue: Bool
    let arrayOfStringValue: [String]
}
