//
//  SearchResultModel.swift
//  Git-Connect
//
//  Created by Shubham Bairagi on 29/02/20.
//  Copyright © 2020 sb. All rights reserved.
//

import Foundation

class SearchResultModel: Decodable {
    
    let totalCount: Int?
    let items: [UserModel]?
}
