//
//  UIImageView+ImageLoader.swift
//  Git-Connect
//
//  Created by Shubham Bairagi on 27/02/20.
//  Copyright © 2020 sb. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(withUrl url: String?, placeHolder: UIImage? = nil, completed: (() -> Void)? = nil) {
        kf.indicatorType = .activity
        if let urlString = url {
            let url = URL(string: urlString)
            self.kf.setImage(with: url, placeholder: placeHolder, options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ], progressBlock: nil) { (_) in
                completed?()
            }
        } else {
            self.image = placeHolder
        }
    }
}

