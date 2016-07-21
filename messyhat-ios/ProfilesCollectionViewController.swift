//
//  ProfileCollectionViewController.swift
//  messyhat-ios
//
//  Created by kelvinfok on 20/7/16.
//  Copyright © 2016 kelvinfok. All rights reserved.
//

import UIKit
import Parse

    var category: Category!

class ProfilesCollectionViewController: UICollectionViewController {
    
    private let heightAdjustment: CGFloat = 50.0
    private let leftAndRightPaddings: CGFloat = 24.0
    private let numberOfItemsPerRow: CGFloat = 2.0
    var selectedCategory = String()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = selectedCategory
    }
    
    func setCollectionViews() {
        
        let width = (CGRectGetWidth(collectionView!.frame) - leftAndRightPaddings) / numberOfItemsPerRow
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSizeMake(width, width + heightAdjustment)
    }


    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 5
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("profileCell", forIndexPath: indexPath)
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("profileCell", forIndexPath: indexPath) 
        
        self.performSegueWithIdentifier("showProfile", sender: cell)
        
        print("Show Profile")
    }

}