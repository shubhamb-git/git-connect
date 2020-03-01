//
//  UITableView+ReuseIdentifier.swift
//  Git-Connect
//
//  Created by Shubham Bairagi on 27/02/20.
//  Copyright © 2020 sb. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: NibLoadable {
    static func register(withTableView tableView: UITableView) {
        tableView.register(defaultNib, forCellReuseIdentifier: defaultReuseIdentifier)
    }
}
