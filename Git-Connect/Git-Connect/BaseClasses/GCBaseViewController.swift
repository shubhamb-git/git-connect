//
//  GCBaseViewController.swift
//  Git-Connect
//
//  Created by Shubham Bairagi on 27/02/20.
//  Copyright © 2020 sb. All rights reserved.
//

import UIKit

class GCBaseViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            if blackStatusBar {
                return UIStatusBarStyle.default
            } else {
                return UIStatusBarStyle.lightContent
            }
        }
    }
    
    @IBInspectable var blackStatusBar: Bool = false
    @IBInspectable var hideNavigationBar: Bool = false {
        didSet {
            self.navigationController?.navigationBar.isHidden = hideNavigationBar
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem?.title = ""
    }
    
}

