//
//  NetworkError.swift
//  Git-Connect
//
//  Created by Shubham Bairagi on 27/02/20.
//  Copyright © 2020 sb. All rights reserved.
//

import Foundation

public enum NetworkError: Error {
    case unknown
    case connection(Error)
    case corruptedData
    case internalServerError
    case requestError(errorMessage: String)
    case webserviceFailure(failureModel: WSFailureModel)
    
    var message: String {
        switch self {
        case .webserviceFailure(let failureModel):
            return failureModel.message ?? localizedDescription
        case .internalServerError:
            return GCConstants.internalServerErrorMessage
        default:
            return localizedDescription
        }
    }
}

