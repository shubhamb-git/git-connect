//
//  LoadingCell.swift
//  Git-Connect
//
//  Created by Shubham Bairagi on 29/02/20.
//  Copyright © 2020 sb. All rights reserved.
//

import UIKit

class LoadingCell: UITableViewCell, Instantiatable {
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
}
