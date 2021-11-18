//
//  User.swift
//  Blogger
//
//  Created by Connor Black on 26/10/2021.
//

import Foundation

struct User: Codable, Hashable {
    let id: UUID
    let firstName: String
    let secondName: String
    let emailAddress: String
    let createdAt: Date
    let updatedAt: Date
    let profilePictureKey: String
    
    var fullName: String {
        "\(firstName) \(secondName)"
    }
}
