//
//  APIClientFetcherMock.swift
//  Blogger
//
//  Created by Connor Black on 12/10/2021.
//

import Foundation
import Promises
@testable import Blogger

struct MockAPIClientService: APIClient {
    
    let fileReader: FileReader
    let jsonSerializer: JsonSerializer
    
    init(fileReader: FileReader = FileReaderService(),
         jsonSerializer: JsonSerializer = JsonSerializerService()) {
        self.fileReader = fileReader
        self.jsonSerializer = jsonSerializer
    }
    
    func getAllBlogPosts() -> Promise<[BlogPost]> {
        return Promise { fulfill, reject in
            do {
                let blogPosts: [BlogPost] = try get(fromFile: "mockBlogPostResponse")
                fulfill(blogPosts)
            } catch (let error) {
                reject(error)
            }
        }
    }
    
    private func get<T: Decodable>(fromFile fileName: String) throws -> [T] {
        let data = try self.fileReader.readData(fromFileName: fileName, withFileType: .json)
        let toReturn: [T] = try jsonSerializer.decode(data: data)
        return toReturn
    }
}
