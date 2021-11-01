//
//  BlogPost.swift
//  Blogger
//
//  Created by Connor Black on 14/10/2021.
//

import Foundation

struct Article: Codable, Identifiable, Hashable {
    let id: UUID
    let authorId: UUID
    let contentId: UUID
    let title: String
}
