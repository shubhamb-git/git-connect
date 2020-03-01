//
//  UserRowCell.swift
//  Git-Connect
//
//  Created by Shubham Bairagi on 29/02/20.
//  Copyright © 2020 sb. All rights reserved.
//

import UIKit

class UserRowCell: UITableViewCell, Instantiatable {
    
    @IBOutlet fileprivate weak var lblUserName: UILabel!
    @IBOutlet fileprivate weak var imgUser: UIImageView!
    @IBOutlet fileprivate weak var lblScore: UILabel!
    
    var user: UserModel? {
        didSet {
            guard let user = user else {
                return
            }
            lblUserName.text = user.login
            lblScore.text = "\(user.score ?? 0)"
            imgUser.setImage(withUrl: user.avatarUrl, placeHolder: GCConstants.PlaceHolder.Image.userImage)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgUser.setCornerRadius(10)
    }
}

