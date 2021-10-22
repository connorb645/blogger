//
//  APIClient.swift
//  Blogger
//
//  Created by Connor Black on 12/10/2021.
//

import Foundation
import Promises

protocol APIClient {
    func getAllBlogPosts() -> Promise<[BlogPost]>
}
