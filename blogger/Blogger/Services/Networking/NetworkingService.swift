//
//  NetworkingService.swift
//  Blogger
//
//  Created by Connor Black on 15/10/2021.
//

import Foundation
import UIKit
import Promises

struct NetworkingService {
    
    private let urlSession: URLSession
    private let requestBuilder: RequestBuilder
    
    init(urlSession: URLSession = URLSession.shared,
         requestBuilder: RequestBuilder = RequestBuilder()) {
        self.urlSession = urlSession
        self.requestBuilder = requestBuilder
    }

    func get(_ endPoint: EndPoint, authType: AuthType? = nil) -> Promise<Data> {
        return Promise { fulfill, reject in
            do {
                let request = try requestBuilder.request(for: endPoint, requestType: .get, authType: authType)
                fulfill(request)
            } catch(let error) {
                reject(error)
            }
        }
        .then { request in
            return try perform(request: request)
        }
    }
   
    func post(_ endPoint: EndPoint,
              params: [String: Any]?,
              authType: AuthType? = nil) -> Promise<Data> {
        return Promise { fulfill, reject in
            do {
                let request = try requestBuilder.request(for: endPoint,
                                                            requestType: .post,
                                                            authType: authType,
                                                            parameters: params)
                fulfill(request)
            } catch (let error) {
                reject(error)
            }
        }.then { request in
            return try perform(request: request)
        }
    }
    
}

extension NetworkingService {
    private func perform(request: URLRequest) throws -> Promise<Data> {
        return Promise { fulfill, reject in
            urlSession.dataTask(with: request) { data, response, error in
                if let error = error {
                    reject(error)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    reject(NetworkError.httpUrlResponseParse)
                    return
                }
                
                let successCodeRange = 200...300
                
                guard successCodeRange.contains(httpResponse.statusCode) else {
                    reject(NetworkError.badStatusCode(code: httpResponse.statusCode))
                    return
                }
                
                guard let data = data else {
                    reject(NetworkError.noData)
                    return
                }
                
                fulfill(data)
                
            }.resume()
        }
    }
}
