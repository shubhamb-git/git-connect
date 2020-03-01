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
                UIAlertController.present(withTitle: GCConstants.unknownErrorMessage)
                return
            }
            // storing current user details
            UserDefaultsManager.loggedInUserDetails = userModel
            
            let window = UIApplication.shared.delegate?.window!
            let vc = GCTabBarController.instance()
            UIView.transition(from: window!.rootViewController!.view, to: vc.view, duration: 0.5, options: UIView.AnimationOptions.curveEaseIn, completion: { (_) in
                window?.rootViewController = vc
            })
        }
    }
    
    func loginFailed(with error: String?) {
        Helper.dispatchAsyncMain { [unowned self] in
            self.loader(show: false)
            UIAlertController.present(withTitle: error)
        }
    }
}
