//
//  RequestBuilderTests.swift
//  BloggerTests
//
//  Created by Connor Black on 22/10/2021.
//

import Foundation
import Quick
import Nimble
@testable import Blogger

class RequestBuilderTests: QuickSpec {
    override func spec() {
        describe("RequestBuilder") {
            context("When building a GET request with no params") {
                
                let requestBuilder = RequestBuilder()
                
                var result: URLRequest? = nil
                var error: Error? = nil
                
                do {
                    result = try requestBuilder.request(for: .blogPosts, requestType: .get, parameters: nil)
                } catch (let e) {
                    error = e
                }
                
                it("Has a valid response") {
                    expect(result).toNot(beNil())
                }
                
                it("Has the correct content type") {
                    expect(result!.allHTTPHeaderFields!["Content-Type"]).to(equal("application/x-www-form-urlencoded"))
                }
                
                it("Has the correct HTTP Method") {
                    expect(result!.httpMethod).to(equal("GET"))
                }
                
                it("Has no body") {
                    expect(result!.httpBody).to(beNil())
                }
                
                it("Does not return an error") {
                    expect(error).to(beNil())
                }
            }
        }
    }
}
