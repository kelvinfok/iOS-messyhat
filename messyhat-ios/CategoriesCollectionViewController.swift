//
//  CategoryCollectionViewController.swift
//  messyhat-ios
//
//  Created by kelvinfok on 19/7/16.
//  Copyright © 2016 kelvinfok. All rights reserved.
//

import UIKit
import Parse

    let categories = Categories()

class CategoriesCollectionViewController: UICollectionViewController {
    
    @IBAction func logout(sender: AnyObject) {
        PFUser.logOut()
        self.checkUserLogin()
    }

    var selectedCategory: String!
    
    struct StoryBoard {
        static let showLoginSegue = "showLogin"
        static let leftAndRightPaddings: CGFloat = 32.0
        static let numberOfItemsPerRow: CGFloat = 3.0
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        checkUserLogin()
        print("Check User Login")
        setCollectionViewsLayout()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        checkUserLogin()
    }
    
    func checkUserLogin() {
        if PFUser.currentUser() == nil {
            print(PFUser.currentUser())
            performSegueWithIdentifier(StoryBoard.showLoginSegue, sender: nil)
        }
        print("Current user is .. \(PFUser.currentUser()?.email)")
    }
    
    // MARK: - CollectionViews Layout
    
    func setCollectionViewsLayout() {
        print("2. Screen Size is \(CGRectGetWidth(collectionView!.frame))")
        let width = (CGRectGetWidth(collectionView!.frame) - StoryBoard.leftAndRightPaddings) / StoryBoard.numberOfItemsPerRow
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSizeMake(width, width)
    }
    
    // MARK: - Mandatory Settings
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return categories.numberOfSections
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.numberOfCategoriesInSection(section)
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("categoryCell", forIndexPath: indexPath) as! CategoryCollectionViewCell
        
        cell.category = categories.categoryForItemAtIndexPath(indexPath)

        return cell
    }
    
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView
    {
        let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "SectionHeader", forIndexPath: indexPath) as! SectionHeaderView
        
        if let category = categories.categoryForItemAtIndexPath(indexPath) {
            headerView.category = category
        }
        
        return headerView
    }
    
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let category = categories.categoryForItemAtIndexPath(indexPath)
        selectedCategory = category!.title
        self.performSegueWithIdentifier("showProfileCollection", sender: category)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showProfileCollection" {
            let destinationController = segue.destinationViewController as! ProfilesCollectionViewController
            destinationController.selectedCategory = selectedCategory
        }
        else if segue.identifier == StoryBoard.showLoginSegue {
            let loginSignupVC = segue.destinationViewController as! LogInSignUpViewController
            loginSignupVC.hidesBottomBarWhenPushed = true
            loginSignupVC.navigationItem.hidesBackButton = true
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}