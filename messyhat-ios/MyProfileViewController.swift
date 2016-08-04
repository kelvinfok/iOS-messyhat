//
//  MyProfileViewController.swift
//  messyhat-ios
//
//  Created by kelvinfok on 20/7/16.
//  Copyright © 2016 kelvinfok. All rights reserved.
//

import UIKit
import Parse

class MyProfileViewController: UIViewController {


    @IBOutlet weak var backgroundTop: UIImageView!
    @IBOutlet weak var backgroundBottom: UIImageView!
    @IBOutlet weak var loginCreateAccountButton: UIButton!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var websiteButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lookingForLabel: UILabel!
    @IBOutlet weak var offeringLabel: UILabel!
    @IBOutlet weak var summaryLabel: UITextView!

    var profiles = Profile()
    
    struct StoryBoard {
        static var segueToLoginSignUp = "segueToLoginSignUp"
        static var segueToCategoryViewController = "segueToCategoryViewController"
        static var segueToWebView = "segueToWebView"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    
    func updateUI() {
        loginCreateAccountButton.layer.masksToBounds = true
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(true)
        
        backgroundTop.hidden = true
        backgroundBottom.hidden = true
        scrollView.hidden = true
        
        self.tabBarController?.tabBar.hidden = false
        
        if currentUserWithProfileLoggedIn() {
            getCurrentProfile()
        }
        else {
            backgroundTop.hidden = false
            backgroundBottom.hidden = false
        }
    }
    
    func currentUserWithProfileLoggedIn() -> Bool {
        
        print("Current User is: \(PFUser.currentUser())")
        print("Current profile is: \(currentProfile)")

            if currentProfile.count > 0 && PFUser.currentUser() != nil {
                    self.scrollView.hidden = false
                    return true
            }
            else if PFUser.currentUser() != nil {
                    ParseHelper.GetCurrentProfile(PFUser.currentUser()!) {
                        (result: [PFObject]?, error: NSError?) -> Void in
                        currentProfile = result as! [Profile]
                        if currentProfile.count > 0 {
                            self.showMyProfile()
                        }
                    }
        }
        self.scrollView.hidden = true
        return false
    }
    
    
    func showMyProfile() -> Bool {
        self.scrollView.hidden = false
        return true
    }
    
    func getCurrentProfile() {
        
        self.scrollView.hidden = false
        self.scrollView.contentOffset = CGPointMake(0, 0)
        
        let ProfileQuery = Profile.query()
        ProfileQuery!.whereKey("user", equalTo: PFUser.currentUser()!)
        ProfileQuery!.findObjectsInBackgroundWithBlock {(result: [PFObject]?, error: NSError?) -> Void in
            
            let userImageFile = result![0]["imageFile"] as! PFFile
        
            userImageFile.getDataInBackgroundWithBlock{
                (imageData: NSData?, error: NSError?) -> Void in
                if error == nil {
                    if let image = UIImage(data: imageData!) {
                        
                        self.profileImageView.contentMode = .ScaleAspectFill
                        self.profileImageView.image = image
                    }
                }
            }
            
   
        self.nameLabel.text = "\(result![0]["first_name"]) \(result![0]["last_name"])"
            
            if result![0]["website"] == nil || result![0]["website"] as! String == "" {
               self.websiteButton.enabled = false
               self.websiteButton.hidden = true
               self.websiteButton.userInteractionEnabled = false
            }
            else {
                self.websiteButton.enabled = true
                self.websiteButton.hidden = false
                self.websiteButton.userInteractionEnabled = true
                self.websiteButton.setTitle("\(result![0]["website"])", forState: .Normal)
            }
            
        self.lookingForLabel.text = "\(result![0]["looking_for"])"
        self.offeringLabel.text = "\(result![0]["offering"])"
        self.summaryLabel.text = "\(result![0]["summary"])"
        self.scrollView.hidden = false
            
            
        }
    }
    
    // MARK: - Actions
    

    @IBAction func visitURL(sender: AnyObject) {
        self.performSegueWithIdentifier(StoryBoard.segueToWebView, sender: self)
    }

    
    @IBAction func loginCreateAction(sender: AnyObject) {
        performSegueWithIdentifier(StoryBoard.segueToLoginSignUp, sender: nil)
    }
    
    @IBAction func signOutButton(sender: AnyObject) {

            PFUser.logOut()
            self.viewWillAppear(true)
    }
    
    
    // MARK: - Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == StoryBoard.segueToWebView {
            let destinationController = segue.destinationViewController as! WebViewController
            destinationController.URLKey = (websiteButton.titleLabel?.text)!
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
