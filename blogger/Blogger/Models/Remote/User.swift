//
//  User.swift
//  Blogger
//
//  Created by Connor Black on 26/10/2021.
//

import Foundation

struct User: Codable, Hashable {
    let id: UUID
    let emailAddress: String
    let firstName: String
    let secondName: String
    
    var fullName: String {
        "\(firstName) \(secondName)"
    }
}
