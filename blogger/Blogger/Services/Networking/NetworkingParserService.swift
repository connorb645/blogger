//
//  NetworkingParserService.swift
//  Blogger
//
//  Created by Connor Black on 24/10/2021.
//

import Foundation
import Promises

struct NetworkingParserService {
    private let jsonSerialization: JsonSerializer
    private let networkingService: NetworkingService
    
    init(jsonSerializer: JsonSerializerService = JsonSerializerService(),
         networkingService: NetworkingService = NetworkingService()) {
        self.jsonSerialization = jsonSerializer
        self.networkingService = networkingService
    }
    
    func get<ResponseType: Codable>(_ endPoint: EndPoint, authType: AuthType? = nil) -> Promise<ResponseType> {
        return networkingService.get(endPoint, authType: authType)
            .then { data in
                let toReturn: ResponseType = try jsonSerialization.decode(data: data)
                return Promise(toReturn)
            }
    }
   
    func post<ResponseType: Codable, ParamType: Codable>(_ endPoint: EndPoint,
                                                         object: ParamType?,
                                                         authType: AuthType? = nil) -> Promise<ResponseType> {
        return Promise { fulfill, reject in
            do {
                let params = try jsonSerialization.jsonRepresentation(object: object)
                fulfill(params)
            } catch (let error) {
                reject(error)
            }
        }.then { params in
            return networkingService.post(endPoint, params: params, authType: authType)
        }.then { data in
            let toReturn: ResponseType = try jsonSerialization.decode(data: data)
            return Promise(toReturn)
        }
    }
    
    func post<ResponseType: Codable>(_ endPoint: EndPoint,
                                     authType: AuthType? = nil) -> Promise<ResponseType> {
        return networkingService.post(endPoint, params: nil, authType: authType).then { data in
            let toReturn: ResponseType = try jsonSerialization.decode(data: data)
            return Promise(toReturn)
        }
    }
    
}
