//
//  WSFailureModel.swift
//  Git-Connect
//
//  Created by Shubham Bairagi on 27/02/20.
//  Copyright © 2020 sb. All rights reserved.
//

import Foundation

public struct WSFailureModel: Decodable {
    let message: String?
    let documentationUrl: String?
}
