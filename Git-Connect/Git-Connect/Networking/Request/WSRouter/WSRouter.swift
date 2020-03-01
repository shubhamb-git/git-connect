//
//  WSRouter.swift
//  Git-Connect
//
//  Created by Shubham Bairagi on 27/02/20. 
//  Copyright © 2020 sb. All rights reserved.
//

import Foundation
import Alamofire

enum WSRouter: RouterProtocol {
    
    case login(_ userName: String)
    case searchUser(_ searchQuery: String, _ pageIndex: Int)
    case repositories(_ userName: String)
    
    var method: HTTPMethod {
        return .get
    }

    var path: String {
        switch self {
        case .login(let userName):
            return EndPoint.login(withUserName: userName)
        case .searchUser(let searchQuery, let pageIndex):
            return EndPoint.searchUser(withSearchQuery: searchQuery, andPageIndex: pageIndex)
        case .repositories(let userName):
            return EndPoint.getRepositories(withUserName: userName)
        }
    }
    
    var parameters: [String : Any]? {
        
        switch self {
        case .searchUser(let searchQuery, let pageIndex):
            return [APIParams.query : searchQuery, APIParams.page : pageIndex]
        default:
            return nil
        }
    }
    
    var encoding: ParameterEncoding {
        return URLEncoding.default
    }
  
    var headers: [String: String]? {
        return nil
    }
}

