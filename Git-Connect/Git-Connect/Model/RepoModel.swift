//
//  RepoModel.swift
//  Git-Connect
//
//  Created by Shubham Bairagi on 29/02/20.
//  Copyright © 2020 sb. All rights reserved.
//

import Foundation

struct RepoModel: Decodable {
    
    let id: Int?
    let stargazersCount: Int?
    let language: String?
    let name: String?
    let nodeId: String?
    let descriptionField: String?
}
