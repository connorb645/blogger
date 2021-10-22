//
//  APIClient.swift
//  Blogger
//
//  Created by Connor Black on 12/10/2021.
//

import Foundation
import Promises

struct APIClientService: APIClient {
    
    private let networkService: NetworkingService
    
    init(networkService: NetworkingService = NetworkingService()) {
        self.networkService = networkService
    }

    func getAllBlogPosts() -> Promise<[BlogPost]> {
        networkService.get(.blogPosts)
    }
}
