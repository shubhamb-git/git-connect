//
//  UserDefaultsManager.swift
//  Git-Connect
//
//  Created by Shubham Bairagi on 27/02/20.
//  Copyright © 2020 sb. All rights reserved.
//

import Foundation

internal struct UserDefaultsManager {
  
    static let applicationDefaults = UserDefaults.standard
   
    static var loggedInUserDetails: UserModel? {
        set {
            let encoder = JSONEncoder()
            let encodedData = try? encoder.encode(newValue)
            applicationDefaults.setValue(encodedData, forKey: GCConstants.UserDefaultsKey.userDetail)
            applicationDefaults.synchronize()
        }
        get {
            if let decoded = applicationDefaults.object(forKey: GCConstants.UserDefaultsKey.userDetail) as? Data {
                let decoder = JSONDecoder()
                return try? decoder.decode(UserModel.self, from: decoded)
            }
            return nil
        }
    }
}

