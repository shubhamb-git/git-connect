//
//  GCLoginVC+ViewModelDelegate.swift
//  Git-Connect
//
//  Created by Shubham Bairagi on 28/02/20.
//  Copyright © 2020 sb. All rights reserved.
//

import UIKit

extension GCLoginVC: LoginViewModelDelegate {
    
    func loginSuccess() {
        Helper.dispatchAsyncMain { [unowned self] in
            self.loader(show: false)
            guard let userModel = self.loginViewModel.userModel else {
                UIAlertController.present(withTitle: "Unknown Error!!!")
                return
            }
            // storing current user details
            UserDefaultsManager.loggedInUserDetails = userModel
            UIAlertController.present(withTitle: "\(userModel.name ?? "User") Logged in")
        }
    }
    
    func loginFailed(with error: String?) {
        Helper.dispatchAsyncMain { [unowned self] in
            self.loader(show: false)
            UIAlertController.present(withTitle: "Unknown Error!!!", description: error)
        }
    }
}
