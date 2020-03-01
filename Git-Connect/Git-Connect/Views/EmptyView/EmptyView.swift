//
//  EmptyView.swift
//  Git-Connect
//
//  Created by Shubham Bairagi on 29/02/20.
//  Copyright © 2020 sb. All rights reserved.
//

import UIKit

class EmptyView: UIView, NibLoadable, Instantiatable {
    
    @IBOutlet private weak var emptyStateLabel: UILabel!
    
    func updateLabel(string: String) {
        if !string.isEmpty {
            emptyStateLabel.text = string
        }
    }
    
}

