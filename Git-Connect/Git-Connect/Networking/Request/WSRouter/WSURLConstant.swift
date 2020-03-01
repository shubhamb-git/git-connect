//
//  WSURLConstant.swift
//  Git-Connect
//
//  Created by Shubham Bairagi on 27/02/20.
//  Copyright © 2020 sb. All rights reserved.
//

import Foundation

struct EndPoint {
    
    static func login(withUserName userName: String) -> String {
        return "users/\(userName)"
    }
    
    static func searchUser(withSearchQuery q: String, andPageIndex page: Int) -> String {
        return "/search/users"
    }
    
    static func getRepositories(withUserName userName: String) -> String {
        return "/users/\(userName)/repos"
    }
}

struct APIParams {
    static let page = "page"
    static let query = "q"
}
