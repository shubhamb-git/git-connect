//
//  Page.swift
//  Git-Connect
//
//  Created by Shubham Bairagi on 29/02/20.
//  Copyright © 2020 sb. All rights reserved.
//

import Foundation

struct Page {
    
    static let `default` = Page(current: 1, total: 1)
    static let itemPerPage = 30
    
    let totalitem: Int
    let currentPage: Int
    let totalPage: Int
    
    var hasNextPage: Bool {
        return currentPage < totalPage
    }
    
    init(current: Int, total: Int) {
        totalitem = total
        totalPage = totalitem/Page.itemPerPage + 1
        currentPage = current > 0 ? current : 1
    }
    
    func getNextPage() -> Int {
        return currentPage + 1
    }
    
}

