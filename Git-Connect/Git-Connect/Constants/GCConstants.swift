//
//  GCConstants.swift
//  Git-Connect
//
//  Created by Shubham Bairagi on 27/02/20.
//  Copyright © 2020 sb. All rights reserved.
//

import Foundation
import UIKit

struct GCConstants {

    static private let protocolo: String = "https://"
    static private let domain: String = "api.github.com"
    static let baseUrl: String = protocolo + domain
    
    static let unknownErrorMessage = "Unknown Error!!!"
    static let internalServerErrorMessage = "Something went wrong, Please try later."
    static let inernetConnectionErrorMessage = "There may be a problem in your internet connection. Please try again!"
        
    struct TabBarItems {
        
        struct SearchTab {
            static let title = "Search"
            static let storyboardId =  "sid_search"
            static let imageEnbled = "SearchEnabled"
            static let imageDisabled = "SearchDisabled"
        }
        
        struct ProfileTab {
            static let title = "Profile"
            static let storyboardId =  "sid_profile"
            static let imageEnbled = "UserEnabled"
            static let imageDisabled = "UserDisabled"
        }
    }

    struct PlaceHolder {
       
        struct Image {
            static let userImage = UIImage(named: "userIcon")
        }
        
        struct Text {
            static let userSearchbarPlaceHolder = "Search by user name"
            static let noRecordFound = "NO USER FOUND"
            static let pullToRefresh = "Pull To Refresh"
            static let connectionError = "Connection Error"
            static let connectionErrorMessage = "Check your network status and pull to refresh"
            static let invalidData = "Invalid Data"
            static let invalidDataErrorMessage = "There is an error when getting data from server. Please pull to refresh"
        }
    }
    
    struct Images {
        static let shareIcon = UIImage(named: "share")
    }
    
    struct UserDefaultsKey {
        static let userDetail = "user_detail"
    }
    
    enum DateFormats {
        static let `default`: String = "yyyy-MM-dd'T'HH:mm:ssZ"
    }

    enum Storyboard: String {
        case login = "LoginModule"
        case search = "SearchModule"
        case profile = "ProfileModule"
        
        var relativeInstance: UIStoryboard {
            return UIStoryboard.init(name: rawValue, bundle: nil)
        }
        
        var instantiateInitialViewController: UIViewController? {
            return relativeInstance.instantiateInitialViewController()
        }
    }
}

