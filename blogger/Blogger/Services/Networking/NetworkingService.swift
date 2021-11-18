//
//  NetworkingService.swift
//  Blogger
//
//  Created by Connor Black on 15/10/2021.
//

import Foundation
import UIKit

struct NetworkingService {
    
    private let urlSession: URLSession
    private let requestBuilder: RequestBuilder
    
    init(urlSession: URLSession = URLSession.shared,
         requestBuilder: RequestBuilder = RequestBuilder()) {
        self.urlSession = urlSession
        self.requestBuilder = requestBuilder
    }
    
    func get(_ endPoint: EndPoint, authType: AuthType? = nil) async throws -> Data? {
        let request = try requestBuilder.request(for: endPoint, requestType: .get, authType: authType)
        return try await perform(request: request)
    }
    
    func post(_ endPoint: EndPoint,
              params: [String: Any]?,
              authType: AuthType? = nil) async throws -> Data? {
        let request = try requestBuilder.request(for: endPoint,
                                                    requestType: .post,
                                                    authType: authType,
                                                    parameters: params)
        return try await perform(request: request)
    }
    
}

extension NetworkingService {
    
    private func perform(request: URLRequest) async throws -> Data {
                
        let (data, response) = try await urlSession.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.httpUrlResponseParse
        }
        
        let successCodeRange = 200...300
        
        guard successCodeRange.contains(httpResponse.statusCode) else {
            throw NetworkError.badStatusCode(code: httpResponse.statusCode)
        }
        
        guard !data.isEmpty else {
            throw NetworkError.noData
        }
        
        return data
    }
    
}
