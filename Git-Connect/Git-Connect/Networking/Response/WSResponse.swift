//
//  WSResponse.swift
//  Git-Connect
//
//  Created by Shubham Bairagi on 27/02/20.
//  Copyright © 2020 sb. All rights reserved.
//

import Foundation

// Receiving Response from ws, either success or failure
class WSResponse<model: Decodable>: Decodable {
    var responseContent: ResponseContent<model>
    
    required init(from decoder: Decoder) throws {
        responseContent = try ResponseContent.init(from: decoder)
    }
}

enum ResponseContent<Value: Decodable>: Decodable {

    case successResult(result: Value)
    case failureResult(result: WSFailureModel)
    
    init(from decoder: Decoder) throws {
        // making decision is api failed or retruning expected result
        if let failureResponse = try? WSFailureModel.init(from: decoder), failureResponse.message != nil, failureResponse.documentationUrl != nil {
            self = .failureResult(result: failureResponse)
        } else {
            self = .successResult(result: try Value.init(from: decoder))
        }
    }
}

