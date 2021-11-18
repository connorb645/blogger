//
//  StubGenerator.swift
//  Blogger
//
//  Created by Connor Black on 29/10/2021.
//

import Foundation

struct StubGenerator {
    var article: Article {
        Article(id: UUID(),
                title: "Article Title",
                authorId: UUID(),
                contentKey: "fake_content_key")
    }
    
    var user: User {
        User(id: UUID(),
             firstName: "fake@gmail.com",
             secondName: "Stubbed",
             emailAddress: "User",
             createdAt: Date(),
             updatedAt: Date(),
             profilePictureKey: "fake_picture_key")
    }
    
    var articleAndAuthor: ArticleAndAuthor {
        ArticleAndAuthor(article: article,
                         author: user)
    }
    
    var articles: [Article] {
        [article, article, article]
    }
}
