//
//  TabBarItem.swift
//  Git-Connect
//
//  Created by Shubham Bairagi on 29/02/20.
//  Copyright © 2020 sb. All rights reserved.
//

import UIKit

enum TabBarItems {
    case Search
    case Profile(_ userModel: UserModel)
    
    var title: String {
        switch self {
        case .Search:
            return GCConstants.TabBarItems.SearchTab.title
        case .Profile:
            return GCConstants.TabBarItems.ProfileTab.title
        }
    }
    
    var storyBoard: UIStoryboard {
        switch self {
        case .Search:
            return GCConstants.Storyboard.search.relativeInstance
        case .Profile:
            return GCConstants.Storyboard.profile.relativeInstance
        }
    }
}
