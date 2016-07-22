//
//  CategoryCollectionViewController.swift
//  messyhat-ios
//
//  Created by kelvinfok on 19/7/16.
//  Copyright © 2016 kelvinfok. All rights reserved.
//

import UIKit

    let categories = Categories()

class CategoriesCollectionViewController: UICollectionViewController {
    
    private let leftAndRightPaddings: CGFloat = 32.0
    private let numberOfItemsPerRow: CGFloat = 3.0
    var selectedCategory: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("2. Screen Size is \(CGRectGetWidth(collectionView!.frame))")
        let width = (CGRectGetWidth(collectionView!.frame) - leftAndRightPaddings) / numberOfItemsPerRow
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSizeMake(width, width)
    }
    
    // MARK: - UICollectionViewDataSource
    
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
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}