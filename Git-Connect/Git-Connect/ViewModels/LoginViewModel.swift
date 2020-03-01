//
//  LoginViewModel.swift
//  Git-Connect
//
//  Created by Shubham Bairagi on 27/02/20.
//  Copyright © 2020 sb. All rights reserved.
//

import UIKit

protocol LoginViewModelDelegate: class {
    func loginSuccess()
    func loginFailed(with error: String?)
}

class LoginViewModel {
    
    weak var delegate: LoginViewModelDelegate?
    private(set) var userModel: UserModel?
    
    init(with delegate: LoginViewModelDelegate) {
        self.delegate = delegate
    }
    
    func login(withUserName userName: String) {
        let router = WSRouter.login(userName)
        
        RequestManager.shared.dataRequest(with: router) { [weak self] (response: ServiceResponse<UserModel>) in
            guard let strongSelf = self else { return }
            switch response {
            case .success(let result):
                strongSelf.userModel = result
                strongSelf.delegate?.loginSuccess()
            case .failure(let error):
                strongSelf.userModel = nil
                strongSelf.delegate?.loginFailed(with: error.message)
            case .notConnectedToInternet:
                strongSelf.userModel = nil
                UIAlertController.internetError(retry: {
                    strongSelf.login(withUserName: userName)
                })
                strongSelf.delegate?.loginFailed(with: nil)
            }
        }
    }
}

