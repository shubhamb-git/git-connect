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
    
    private var favoriteUsers: [Int]?
    
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

    func addToFavorite(withUserId userId: Int?) {
        guard let userId = userId else { return }
        if favoriteUsers == nil {
            favoriteUsers = [Int]()
        }
        favoriteUsers?.append(userId)
    }

    func removeFromFavorite(withUserId userId: Int?) {
        guard let userId = userId, let index = favoriteUsers?.firstIndex(of: userId) else { return }
        favoriteUsers?.remove(at: index)
    }
    
    func isUserFavorite(withUserId userId: Int?) -> Bool {
        guard let userId = userId else { return false }
        return favoriteUsers?.contains(userId) ?? false
    }
}
