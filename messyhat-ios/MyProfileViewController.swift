//
//  MyProfileViewController.swift
//  messyhat-ios
//
//  Created by kelvinfok on 20/7/16.
//  Copyright © 2016 kelvinfok. All rights reserved.
//

import UIKit
import Parse

class MyProfileViewController: UIViewController{

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var visualEffects: UIVisualEffectView!
    @IBOutlet weak var loginCreateAccountButton: UIButton!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lookingForLabel: UILabel!
    @IBOutlet weak var offeringLabel: UILabel!
    @IBOutlet weak var summaryLabel: UITextView!

    var profiles = Profile()
    
    struct StoryBoard {
        static var segueToLoginSignUp = "segueToLoginSignUp"
        static var segueToCategoryViewController = "segueToCategoryViewController"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    
    func updateUI() {
        loginCreateAccountButton.layer.cornerRadius = 5.0
        loginCreateAccountButton.layer.masksToBounds = true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        background.hidden = true
        visualEffects.hidden = true
        activityIndicator.hidden = true
        
        self.tabBarController?.tabBar.hidden = false
        
        if currentUserLoggedIn() {
            // current user is logged in
            self.activityIndicator.hidden = false
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
            activityIndicator.color = UIColor.darkGrayColor()
            activityIndicator.startAnimating()
            getCurrentProfile()
        }
        else {
            // no user logged in
            background.hidden = false
            visualEffects.hidden = false
        }
    }
    
    func currentUserLoggedIn() -> Bool {
        if PFUser.currentUser() != nil {
            return true
        }
        else {
            scrollView.hidden = true
            return false
        }
    }
    
    func getCurrentProfile() {

        let ProfileQuery = Profile.query()
        ProfileQuery!.whereKey("user", equalTo: PFUser.currentUser()!)
        ProfileQuery!.findObjectsInBackgroundWithBlock {(result: [PFObject]?, error: NSError?) -> Void in
        
        self.activityIndicator.stopAnimating()
        self.activityIndicator.hidden = true
            
            let userImageFile = result![0]["imageFile"] as! PFFile
        
            userImageFile.getDataInBackgroundWithBlock{
                (imageData: NSData?, error: NSError?) -> Void in
                if error == nil {
                    if let image = UIImage(data: imageData!) {
                        self.profileImageView.image = image
                    }
                }
            }
            
            self.activityIndicator.stopAnimating()
            self.activityIndicator.hidden = true
   
        self.nameLabel.text = "\(result![0]["first_name"]) \(result![0]["last_name"])"
        self.countryLabel.text = "\(result![0]["country"])"
        self.lookingForLabel.text = "\(result![0]["looking_for"])"
        self.offeringLabel.text = "\(result![0]["offering"])"
        self.summaryLabel.text = "\(result![0]["summary"])"
        self.scrollView.hidden = false
            
            
        }
    }
    
    // MARK: - Actions
    

    @IBAction func loginCreateAction(sender: AnyObject) {
        performSegueWithIdentifier(StoryBoard.segueToLoginSignUp, sender: nil)
    }
    
    
    @IBAction func signOutButton(sender: AnyObject) {

            PFUser.logOut()
            //view.setNeedsDisplay()
            self.viewWillAppear(true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
