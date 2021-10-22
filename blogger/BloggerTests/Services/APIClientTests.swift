//
//  BloggerTests.swift
//  BloggerTests
//
//  Created by Connor Black on 11/10/2021.
//

import XCTest
import Nimble
import Quick
@testable import Blogger

class APIClientTests: QuickSpec {
    override func spec() {
        describe("APIClient") {
            context("When calling getAllBlogPosts()") {
                
                let bundle = Bundle(for: type(of: self))
                let fileReader: FileReader = FileReaderService(bundle: bundle)
                let apiClient: APIClient = MockAPIClientService(fileReader: fileReader)
                
                var returnedBlogPosts: [BlogPost] = []
                
                apiClient.getAllBlogPosts()
                    .then { blogPosts in
                        returnedBlogPosts = blogPosts
                    }
                    .catch { error in
                        print(error)
                    }
                
                it("Returns the correct number of blog posts") {
                    expect(returnedBlogPosts.count).toEventually(equal(2))
                }
            }
        }
    }
}
