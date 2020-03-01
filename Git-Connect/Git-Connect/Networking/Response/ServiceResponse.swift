//
//  Response.swift
//  Git-Connect
//
//  Created by Shubham Bairagi on 27/02/20.
//  Copyright © 2020 sb. All rights reserved.
//

import Foundation
import Alamofire

enum ServiceResponse<T: Decodable> {
    case success(response: T)
    case failure(error: NetworkError)
    case notConnectedToInternet
}
