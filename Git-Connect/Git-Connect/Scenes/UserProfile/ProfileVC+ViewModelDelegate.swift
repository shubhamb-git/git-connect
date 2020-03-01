//
//  ProfileVC+ViewModelDelegate.swift
//  Git-Connect
//
//  Created by Shubham Bairagi on 29/02/20.
//  Copyright © 2020 sb. All rights reserved.
//

import UIKit

extension ProfileVC: ProfileViewModelDelegate {
    
    func didLoad() {
        self.viewModel?.delegate = self
        
        // api call for usr details
        self.loader(show: true)
        self.viewModel?.getUserDetails()
    }
    
    func didReceivedUserDetails() {
        Helper.dispatchAsyncMain { [unowned self] in
            self.loader(show: false)
            self.updateUI()
        }
    }
    
    func didReceivedRepositories() {
        Helper.dispatchAsyncMain { [unowned self] in
            self.loader(show: false)
            self.reposTableView?.reloadData()
        }
    }
    
    func failed(with error: String?) {
        Helper.dispatchAsyncMain { [unowned self] in
            self.loader(show: false)
            UIAlertController.present(withTitle: error)
        }
    }
}

