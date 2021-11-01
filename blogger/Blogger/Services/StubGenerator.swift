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
                authorId: UUID(),
                contentId: UUID(),
                title: "Article Title")
    }
    
    var user: User {
        User(id: UUID(),
             emailAddress: "fake@gmail.com",
             firstName: "Stubbed",
             secondName: "User")
    }
    
    var articleAndAuthor: ArticleAndAuthor {
        ArticleAndAuthor(article: article,
                         author: user)
    }
}
