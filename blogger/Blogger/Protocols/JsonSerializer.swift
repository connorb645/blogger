//
//  JsonDecoder.swift
//  Blogger
//
//  Created by Connor Black on 13/10/2021.
//

import Foundation

protocol JsonSerializer {
    func decode<T: Decodable>(data: Data) throws -> T
    func encode<T: Encodable>(object: T) throws -> Data
    func jsonRepresentation<T: Codable>(object: T) throws -> [String: Any]
}
