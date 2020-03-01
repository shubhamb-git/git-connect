//
//  DateFormatter+CustomFormatter.swift
//  Git-Connect
//
//  Created by Shubham Bairagi on 27/02/20.
//  Copyright © 2020 sb. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    static private let customDateFormatter = DateFormatter()
    
    static func string(from date: Date, format: String) -> String {
        customDateFormatter.dateFormat = format
        return customDateFormatter.string(from: date)
    }
    
    static func date(from string: String, format: String) -> Date? {
        customDateFormatter.dateFormat = format
        return customDateFormatter.date(from: string)
    }
}
