//
//  BlogPost.swift
//  Blogger
//
//  Created by Connor Black on 14/10/2021.
//

import Foundation

struct BlogPost: Codable {
    let id: UUID
    let authorId: UUID
    let title: String
}
