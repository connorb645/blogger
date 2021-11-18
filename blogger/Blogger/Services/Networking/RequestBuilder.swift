//
//  RequestBuilder.swift
//  Blogger
//
//  Created by Connor Black on 22/10/2021.
//

import Foundation

struct RequestBuilder {
    
    private let baseUrlGenerator: BaseUrlGenerator
    
    init(baseUrlGenerator: BaseUrlGenerator = BaseUrlGenerator()) {
        self.baseUrlGenerator = baseUrlGenerator
    }
    
    public func request(for endPoint: EndPoint,
                        requestType: RequestType,
                        authType: AuthType?,
                        parameters: [String: Any]? = nil) throws -> URLRequest {
        guard let url = URL(string: "\(baseUrlGenerator.baseUrl)\(endPoint.path)") else {
            throw RequestBuilderError.urlParse
        }
        var request = URLRequest(url: url)
        
        if let authType = authType {
            request.setValue(authType.value, forHTTPHeaderField: authType.header)
        }
        
        if  requestType == .post ||
            requestType == .put {
            
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        }

        request.httpMethod = requestType.rawValue
        if let params = parameters {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            } catch (let error) {
                throw RequestBuilderError.parameterDecoding(error: error)
            }
        }
        
        return request
    }
}
