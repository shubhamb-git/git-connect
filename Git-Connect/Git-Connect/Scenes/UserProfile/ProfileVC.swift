//
//  ProfileVC.swift
//  Git-Connect
//
//  Created by Shubham Bairagi on 29/02/20.
//  Copyright © 2020 sb. All rights reserved.
//

import UIKit

class ProfileVC: GCBaseViewController {
    
    enum C {
        static let contentCellHeight: CGFloat = 70.0
        static let headerPortraitHeight: CGFloat = UIScreen.main.bounds.width * 0.8 // maintaining 5/4 ratio
    }
    
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblBio: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    
    @IBOutlet weak var lblFollowersCount: UILabel!
    @IBOutlet weak var lblFollowingCount: UILabel!
    
    @IBOutlet weak var reposTableView: UITableView?
    @IBOutlet weak var headerPortraitHeightConstraint: NSLayoutConstraint!
    
    lazy var favoriteButton: UIButton = {
        let favoriteButton = UIButton.init(type: .custom)
        favoriteButton.setImage(GCConstants.Images.favoriteNormal, for: .normal)
        favoriteButton.setImage(GCConstants.Images.favoriteSelected, for: .selected)
        favoriteButton.addTarget(self, action: #selector(ProfileVC.favoriteButtonTapped(_:)), for: .touchUpInside)
        return favoriteButton
    }()

    
    var viewModel: ProfileViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        // viewmodel delegation and api call for user details
        self.didLoad()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateTableContentInset()
    }
    
    // updating tablview inset on orientation change
    fileprivate func updateTableContentInset() {
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
            reposTableView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            
        } else {
            print("Portrait")
            reposTableView?.contentInset = UIEdgeInsets(top: C.headerPortraitHeight, left: 0, bottom: 0, right: 0)
        }
    }
}

extension ProfileVC {
    
    func setupUI() {
        // show share icon only if viewing other user profile
        if UserDefaultsManager.loggedInUserDetails?.id != self.viewModel?.userModel?.id {
            self.navigationBarSetup()
        } 

        headerPortraitHeightConstraint.constant = C.headerPortraitHeight
        reposTableView?.register(RepoRowCell.defaultNib, forCellReuseIdentifier: RepoRowCell.defaultReuseIdentifier)
        
        if let user = viewModel?.userModel {
            self.navigationItem.title = user.login
            self.imageUser.setImage(withUrl: user.avatarUrl, placeHolder:  GCConstants.PlaceHolder.Image.userImage)
        }
        updateTableContentInset()
        reposTableView?.dataSource = viewModel?.repoViewModel
        reposTableView?.delegate = viewModel?.repoViewModel
        viewModel?.repoViewModel.delegate = self
    }
    
    func navigationBarSetup() {
        favoriteButton.isSelected = UserDefaultsManager.loggedInUserDetails?.isUserFavorite(withUserId: self.viewModel?.userModel?.id) ?? false
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: favoriteButton)
    }

    func updateUI() {
        if let user = viewModel?.userModel {
            self.lblUserName.text = user.name
            self.lblBio.text = user.bio?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            self.lblLocation.text   = user.location
            self.lblFollowersCount.text = "\(user.followers ?? 0)"
            self.lblFollowingCount.text = "\(user.following ?? 0)"
        }
    }
    
    @objc func favoriteButtonTapped(_ sender: UIButton) {
        guard let loggedUser = UserDefaultsManager.loggedInUserDetails else {
            return
        }
        if sender.isSelected {
            loggedUser.removeFromFavorite(withUserId: self.viewModel?.userModel?.id)
        } else {
            loggedUser.addToFavorite(withUserId: self.viewModel?.userModel?.id)
        }
        UserDefaultsManager.loggedInUserDetails = loggedUser
        sender.isSelected = !sender.isSelected
    }
}

extension ProfileVC: RepoViewModelDelegate {
    
    func didScroll(withNewHeight height: CGFloat) {
        headerPortraitHeightConstraint.constant = height
    }
}

