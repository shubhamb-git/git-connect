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
    
    static let internalServerErrorMessage = "Something went wrong, Please try later."
    static let inernetConnectionErrorMessage = "There may be a problem in your internet connection. Please try again!"
    
    struct PlaceHolder {
        struct Image {
            
        }
        struct Text {
        }
    }
    
    struct Images {
    }
    
    struct UserDefaultsKey {
        static let userDetail = "user_detail"
    }
    
    enum DateFormats {
        static let `default`: String = "yyyy-MM-dd'T'HH:mm:ssZ"
    }
}

