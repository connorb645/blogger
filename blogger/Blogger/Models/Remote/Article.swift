//
//  BlogPost.swift
//  Blogger
//
//  Created by Connor Black on 14/10/2021.
//

import Foundation

struct Article: Codable, Identifiable, Hashable {
    var id: UUID
    var title: String
    var authorId: UUID
    var contentKey: String
    var createdAt: Date?
    var updatedAt: Date?
}

