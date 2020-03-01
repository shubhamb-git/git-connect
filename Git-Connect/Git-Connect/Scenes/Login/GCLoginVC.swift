//
//  GCLoginVC.swift
//  Git-Connect
//
//  Created by Shubham Bairagi on 27/02/20.
//  Copyright © 2020 sb. All rights reserved.
//

import UIKit

class GCLoginVC: GCBaseViewController {

    @IBOutlet weak var textFieldUserName: UITextField?

    lazy var loginViewModel = LoginViewModel.init(with: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        loader(show: true)
        loginViewModel.login(withUserName: "shubhamb-git")
    }

        
    deinit {
        print("GCLoginVC Deinit")
    }
}

