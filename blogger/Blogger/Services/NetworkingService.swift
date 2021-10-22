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
    
    private let jsonSerializationService: JsonSerializer
    private let urlSession: URLSession
    private let baseUrlGenerator: BaseUrlGenerator
    
    init(urlSession: URLSession = URLSession.shared,
         jsonSerializationService: JsonSerializer = JsonSerializerService(),
         baseUrlGenerator: BaseUrlGenerator = BaseUrlGenerator()) {
        self.jsonSerializationService = jsonSerializationService
        self.urlSession = urlSession
        self.baseUrlGenerator = baseUrlGenerator
    }

#warning("Doesn't have a test")
    func get<ResponseType: Codable>(_ endPoint: EndPoint) -> Promise<ResponseType> {
        return Promise { fulfill, reject in
            do {
                let request = try request(for: endPoint, requestType: .get)
                fulfill(request)
            } catch(let error) {
                reject(error)
            }
        }
        .then { request in
            return try perform(request: request)
        }
    }
   
#warning("Doesn't have a test")
    func post<ResponseType: Codable,ParamType: Codable>(_ endPoint: EndPoint, object: ParamType?) -> Promise<ResponseType> {
        return Promise { fulfill, reject in
            do {
                let params = try jsonSerializationService.jsonRepresentation(object: object)
                fulfill(params)
            } catch (let error) {
                reject(error)
            }
        }.then { params in
            return try request(for: endPoint, requestType: .post, parameters: params)
        }.then { request in
            return try perform(request: request)
        }
    }
    
}

extension NetworkingService {
    private func request(for endPoint: EndPoint, requestType: RequestType, parameters: [String: Any]? = nil) throws -> URLRequest {
        guard let url = URL(string: "\(baseUrlGenerator.baseUrl)\(endPoint.rawValue)") else {
            throw NetworkError.urlParse
        }
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = requestType.rawValue
        if let params = parameters {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            } catch (let error) {
                throw NetworkError.parameterDecoding(error: error)
            }
        }
        
        return request
    }
}

extension NetworkingService {
    private func perform<T: Codable>(request: URLRequest) throws -> Promise<T> {
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
                
                do {
                    let toReturn: T = try jsonSerializationService.decode(data: data)
                    fulfill(toReturn)
                } catch (let error) {
                    reject(error)
                }
                
            }.resume()
        }
    }
}
