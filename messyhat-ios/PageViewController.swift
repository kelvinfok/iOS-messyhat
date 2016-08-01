//
//  PageViewController.swift
//  messyhat-ios
//
//  Created by kelvinfok on 1/8/16.
//  Copyright © 2016 kelvinfok. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    
    var pageHeaders = ["What is MessyHat?", "How to use this app?", "Initiate projects with Messyhat"]
    var pageImages = ["app1", "app2", "app3"]
    var pageDescriptions = ["Messyhat is a barter network for members to trade skillsets without money.",
                            "Create a profile and talk to members to exchange skillsets.", "Start your projects with members in the network"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        
        if let startWalkThroughVC = self.viewControllerAtIndex(0) {
            setViewControllers([startWalkThroughVC], direction: .Forward, animated: true, completion: nil)
        }
    }
    
    func nextPageWithIndex(index: Int) {
        
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
























