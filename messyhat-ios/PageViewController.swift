//
//  PageViewController.swift
//  messyhat-ios
//
//  Created by kelvinfok on 1/8/16.
//  Copyright © 2016 kelvinfok. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    
    var pageHeaders = ["What is MessyHat?", "How to use this app?", "Initiate and collaborate"]
    var pageImages = ["app1", "app2", "app3"]
    var pageDescriptions = ["MessyHat is a barter network for members to trade and learn new skillsets without money.",
                            "Create a profile, browse through members profiles, arrange a meetup and exchange skillsets.", "Start your projects with quality team members in the network"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        
        if let startWalkThroughVC = self.viewControllerAtIndex(0) {
            setViewControllers([startWalkThroughVC], direction: .Forward, animated: true, completion: nil)
        }
    }
    
    func nextPageWithIndex(index: Int) {
        if let nextWalkthroughVC = self.viewControllerAtIndex(index + 1) {
            setViewControllers([nextWalkthroughVC], direction: .Forward, animated: true, completion: nil)
        }
    }
    
    func viewControllerAtIndex(index: Int) -> WalkThroughViewController? {
        if index == NSNotFound || index < 0 || index >= self.pageDescriptions.count {
            return nil
        }
        
        if let WalkThroughViewController = storyboard?.instantiateViewControllerWithIdentifier("walkthroughViewController") as? WalkThroughViewController {
            WalkThroughViewController.imageName = pageImages[index]
            WalkThroughViewController.headerText = pageHeaders[index]
            WalkThroughViewController.descriptionText = pageDescriptions[index]
            WalkThroughViewController.index = index
            
            return WalkThroughViewController
        }
        
        return nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension PageViewController: UIPageViewControllerDataSource {
    
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! WalkThroughViewController).index
        index -= 1
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! WalkThroughViewController).index
        index += 1
        return self.viewControllerAtIndex(index)
    }
    
    
    
}