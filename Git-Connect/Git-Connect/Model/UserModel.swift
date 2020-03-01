//
//  UserModel.swift
//  Git-Connect
//
//  Created by Shubham Bairagi on 27/02/20.
//  Copyright © 2020 sb. All rights reserved.
//

import Foundation

class UserModel: Codable {
    let avatarUrl: String?
    let bio: String?
    let createdAt: String?
    let email: String?
    let followers: Int?
    let following: Int?
    let id: Int?
    let location: String?
    let login: String?
    let name: String?
    let htmlUrl: String?
    let type: String?
    let updatedAt: String?
    let score: Double?
    
    var updatedDate: Date? {
        if let updatedAt = updatedAt {
            return DateFormatter.date(from: updatedAt, format: GCConstants.DateFormats.default)
        }
        return nil
    }
    
    var createdDate: Date? {
        if let createdAt = createdAt {
            return DateFormatter.date(from: createdAt, format: GCConstants.DateFormats.default)
        }
        return nil
    }

}
