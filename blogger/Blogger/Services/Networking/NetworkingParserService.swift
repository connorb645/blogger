//
//  NetworkingParserService.swift
//  Blogger
//
//  Created by Connor Black on 24/10/2021.
//

import Foundation

struct NetworkingParserService {
    private let jsonSerialization: JsonSerializer
    private let networkingService: NetworkingService
    
    init(jsonSerializer: JsonSerializerService = JsonSerializerService(),
         networkingService: NetworkingService = NetworkingService()) {
        self.jsonSerialization = jsonSerializer
        self.networkingService = networkingService
    }
    
    func get<ResponseType: Codable>(_ endPoint: EndPoint, authType: AuthType? = nil) async throws -> ResponseType? {
        let data = try await networkingService.get(endPoint, authType: authType)
        
        guard let data = data else {
            return nil
        }
        
        guard !data.isEmpty else {
            return nil
        }
        
        return try jsonSerialization.decode(data: data)
    }

    func post<ResponseType: Codable, ParamType: Codable>(_ endPoint: EndPoint,
                                                         object: ParamType?,
                                                         authType: AuthType? = nil) async throws -> ResponseType? {
        let params = try jsonSerialization.jsonRepresentation(object: object)
        
        guard let data = try await networkingService.post(endPoint, params: params, authType: authType) else {
            return nil
        }
        
        return try jsonSerialization.decode(data: data)
    }
    
    func post<ResponseType: Codable>(_ endPoint: EndPoint,
                                     authType: AuthType? = nil) async throws -> ResponseType? {
        guard let data = try await networkingService.post(endPoint, params: nil, authType: authType) else {
            return nil
        }
        return try jsonSerialization.decode(data: data)
    }
    
}
