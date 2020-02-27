//
//  RouterProtocol.swift
//  Git-Connect
//
//  Created by Shubham Bairagi on 27/02/20.
//  Copyright © 2020 sb. All rights reserved.
//

import Foundation
import Alamofire

public protocol RouterProtocol: URLRequestConvertible {

    // The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }
    
    // The HTTP method used in the request.
    var method: HTTPMethod { get }
    
    // The HTTP parameters used in the request.
    var parameters: Parameters? { get }
    
    // The HTTP parameters encoding format used in the request
    var encoding: ParameterEncoding { get }
    
    // The headers to be used in the request.
    var headers: [String: String]? { get }
    
}

extension RouterProtocol {
    
    public func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: GCConstants.baseUrl) else {
            
            throw(NetworkError.requestError(errorMessage: "Unable to create url"))
        }
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.timeoutInterval = 30.0 // in seconds
        do {
            return try encoding.encode(request, with: parameters)
        } catch {
            throw error
        }
    }
}


