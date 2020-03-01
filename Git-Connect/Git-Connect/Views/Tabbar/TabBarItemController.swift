//
//  TabBarItemController.swift
//  Git-Connect
//
//  Created by Shubham Bairagi on 29/02/20.
//  Copyright © 2020 sb. All rights reserved.
//

import UIKit

struct TabBarItemController {
    
    let controller: UIViewController
    let imageEnbled: String
    let imageDisabled: String
    private let storyBoardId: String
    
    init(itemType: TabBarItems) {
        
        switch itemType {
        case .Search:
            self.storyBoardId = GCConstants.TabBarItems.SearchTab.storyboardId
            self.controller = itemType.storyBoard
                .instantiateViewController(withIdentifier: storyBoardId)
                as! SearchVC
            self.imageEnbled = GCConstants.TabBarItems.SearchTab.imageEnbled
            self.imageDisabled = GCConstants.TabBarItems.SearchTab.imageDisabled
        case .Profile(let userModel):
            self.storyBoardId = GCConstants.TabBarItems.ProfileTab.storyboardId
            let profileVC = itemType.storyBoard
                .instantiateViewController(withIdentifier: storyBoardId)
                as! ProfileVC
            profileVC.viewModel = ProfileViewModel.init(user: userModel)
            self.controller = profileVC
            self.imageEnbled = GCConstants.TabBarItems.ProfileTab.imageEnbled
            self.imageDisabled = GCConstants.TabBarItems.ProfileTab.imageDisabled
        }
    }
}


