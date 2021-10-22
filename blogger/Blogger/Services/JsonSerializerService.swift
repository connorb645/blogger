//
//  JsonDecoder.swift
//  Blogger
//
//  Created by Connor Black on 13/10/2021.
//

import Foundation

struct JsonSerializerService: JsonSerializer {
    
    func decode<T>(data: Data) throws -> T where T : Decodable {
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(T.self, from: data)
        } catch (let error) {
            throw JsonSerializerError.decodingFailed(error: error)
        }
    }
    
    func encode<T>(object: T) throws -> Data where T : Encodable {
        let encoder = JSONEncoder()
        do {
            return try encoder.encode(object)
        } catch (let error) {
            throw JsonSerializerError.encodingFailed(error: error)
        }
    }
    
    func jsonRepresentation<T>(object: T) throws -> [String : Any] where T : Decodable, T : Encodable {
        do {
            let paramsData = try encode(object: object)
            guard let params = try JSONSerialization.jsonObject(with: paramsData, options: []) as? [String: Any] else {
                throw JsonSerializerError.jsonRepresentationFailed(error: nil)
            }
            
            return params
        } catch (let error) {
            throw JsonSerializerError.jsonRepresentationFailed(error: error)
        }
    }
}
