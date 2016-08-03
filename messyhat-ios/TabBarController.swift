//
//  tabController.swift
//  messyhat-ios
//
//  Created by kelvinfok on 3/8/16.
//  Copyright © 2016 kelvinfok. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    
    override func viewDidLoad() {
        self.delegate = self
    }
    
    
    
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        // print("tab selected")
    }
    
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        
        return true
    }
    
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        // print(item.tag)
        // print(item.title)
    }
    
    
    override func setViewControllers(viewControllers: [UIViewController]?, animated: Bool) {
        
    }
    
}