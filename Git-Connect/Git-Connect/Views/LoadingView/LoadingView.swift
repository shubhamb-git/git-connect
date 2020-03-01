//
//  LoadingView.swift
//  Git-Connect
//
//  Created by Shubham Bairagi on 28/02/20.
//  Copyright © 2020 sb. All rights reserved.
//

import UIKit

class LoadingView: UIView, NibLoadable, Instantiatable {
    
    @IBOutlet private weak var loadingView: UIView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var loadingLabel: UILabel!
    
    override func awakeFromNib() {
        loadingView.setCornerRadius(5)
        loadingView.backgroundColor = .clear
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.insertSubview(blurView, at: 0)
        
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: loadingView.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: loadingView.widthAnchor),
            ])
    }
    
    deinit {
        print("LoadingView deinit")
    }
    
}
