//
//  RepoViewModel.swift
//  Git-Connect
//
//  Created by Shubham Bairagi on 29/02/20.
//  Copyright © 2020 sb. All rights reserved.
//

import UIKit

protocol RepoViewModelDelegate: class {
    func didScroll(withNewHeight height: CGFloat)
}

class RepoViewModel: NSObject {
    
    var selectionHandler: ((String) -> Void)?
    lazy var repositories = [RepoModel]()
    weak var delegate: RepoViewModelDelegate?
    
    func getRepositories(ofUser userName: String, completion: @escaping ((Bool, String?) -> Void)) {
        let router = WSRouter.repositories(userName)
        
        RequestManager.shared.dataRequest(with: router) { [weak self] (response: ServiceResponse<[RepoModel]>) in
            guard let strongSelf = self else { return }
            switch response {
            case .success(let value):
                strongSelf.repositories = value
                completion(true, nil)
            case .failure(let error):
                strongSelf.repositories = []
                completion(true, error.message)
            case .notConnectedToInternet:
                strongSelf.repositories = []
                UIAlertController.internetError(retry: {
                    strongSelf.getRepositories(ofUser: userName, completion: completion)
                })
                completion(true, GCConstants.inernetConnectionErrorMessage)
            }
        }
    }
    
    deinit {
        print("RepoViewModel deinit")
    }
}

extension RepoViewModel: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepoRowCell.defaultReuseIdentifier,
                                                 for: indexPath) as! RepoRowCell
        cell.repo = repositories[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
}

extension RepoViewModel: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return ProfileVC.C.contentCellHeight
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = ProfileVC.C.headerPortraitHeight - (scrollView.contentOffset.y + ProfileVC.C.headerPortraitHeight)
        let height = min(max(y, 0), 400)
        delegate?.didScroll(withNewHeight: height)
    }
}


