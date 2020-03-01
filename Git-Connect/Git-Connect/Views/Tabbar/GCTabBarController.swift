//
//  TabBarController.swift
//  Git-Connect
//
//  Created by Shubham Bairagi on 29/02/20.
//  Copyright © 2020 sb. All rights reserved.
//

import UIKit

class GCTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    lazy var arrayVc = [UIViewController]()
    var itemController: TabBarItemController!
    
    static func instance() -> GCTabBarController {
         return GCTabBarController.init(nibName: GCTabBarController.stringRepresentation, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        arrayVc.append(setViewControllerForTabBarItem(itemType: .Search))
        arrayVc.append(setViewControllerForTabBarItem(itemType: .Profile(UserDefaultsManager.loggedInUserDetails!)))
        viewControllers = arrayVc
        self.tabBar.tintColor = #colorLiteral(red: 0.3714280128, green: 0.7955666184, blue: 0.6633711457, alpha: 1)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}

private extension GCTabBarController {
    
    func setViewControllerForTabBarItem(itemType: TabBarItems) -> UIViewController {
        itemController =  TabBarItemController(itemType: itemType)
        let imageDisabled = UIImage(named: itemController.imageDisabled)
        let selectedImage = UIImage(named:itemController.imageEnbled)
        itemController.controller.tabBarItem = UITabBarItem(title: itemType.title, image: imageDisabled, selectedImage: selectedImage)
        return UINavigationController(rootViewController: itemController.controller)
    }
}


