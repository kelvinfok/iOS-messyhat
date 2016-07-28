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
    
    var profiles = [Profile]()
    var profileIndex = Int()
    
    private let heightAdjustment: CGFloat = 50.0
    private let leftAndRightPaddings: CGFloat = 24.0
    private let numberOfItemsPerRow: CGFloat = 2.0

    var selectedCategory = String()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        title = selectedCategory
        setCollectionViews()
        getNumberofProfiles()
        
    }
    
    
    
    func setCollectionViews() {
        
        let width = (CGRectGetWidth(collectionView!.frame) - leftAndRightPaddings) / numberOfItemsPerRow
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSizeMake(width, width + heightAdjustment)
    }
    
    func getNumberofProfiles() {
        ParseHelper.ProfilesRequestForCurrentCategory(selectedCategory) {
            (result: [PFObject]?, error: NSError?) -> Void in
            
            self.profiles = result as! [Profile]
            print("3. Profiles Object: \(self.profiles)")
            print("4. Profiles Count: \(self.profiles.count)")
            self.collectionView?.reloadData()
            
        }
    }


    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return profiles.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("profileCell", forIndexPath: indexPath) as! ProfileViewCell
        
        cell.profile = self.profiles[indexPath.row]
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("profileCell", forIndexPath: indexPath)
        self.profileIndex = indexPath.row
        self.performSegueWithIdentifier("showProfile", sender: cell)
        print("5. Index Path is: \(self.profileIndex)")

    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showProfile" {
            let destinationController = segue.destinationViewController as! ProfileViewController
            destinationController.profiles = self.profiles[self.profileIndex]
            
        }
    }
    
    

}