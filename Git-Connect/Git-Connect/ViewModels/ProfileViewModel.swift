//
//  ProfileViewModel.swift
//  Git-Connect
//
//  Created by Shubham Bairagi on 29/02/20.
//  Copyright © 2020 sb. All rights reserved.
//

import UIKit

protocol ProfileViewModelDelegate: class {
    func didReceivedUserDetails()
    func didReceivedRepositories()
    func failed(with error: String?)
}

class ProfileViewModel {
    
    weak var delegate: ProfileViewModelDelegate?
    private(set) var userModel: UserModel?
    fileprivate(set) var repoViewModel = RepoViewModel()
    
    init(user: UserModel) {
        self.userModel = user
    }
    
    func getUserDetails() {
        guard let userId = userModel?.login else { return }
        let router = WSRouter.login(userId)
        
        RequestManager.shared.dataRequest(with: router) { [weak self] (response: ServiceResponse<UserModel>) in
            guard let strongSelf = self else { return }
            switch response {
            case .success(let value):
                strongSelf.userModel = value
                strongSelf.repoViewModel.getRepositories(ofUser: value.login!, completion: { (success, errorMessage) in
                    if success {
                        strongSelf.delegate?.didReceivedRepositories()
                    } else {
                        strongSelf.delegate?.failed(with: errorMessage ?? "Unknown error")
                    }
                })
                strongSelf.delegate?.didReceivedUserDetails()
            case .failure(let error):
                strongSelf.userModel = nil
                strongSelf.delegate?.failed(with: error.message)
            case .notConnectedToInternet:
                strongSelf.userModel = nil
                UIAlertController.internetError(retry: {
                    strongSelf.getUserDetails()
                })
                strongSelf.delegate?.failed(with: nil)
            }
        }
    }
    
    deinit {
        print("UserViewModel deinit")
    }
}

