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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginCreateAccountButton.layer.cornerRadius = 5.0
        loginCreateAccountButton.layer.masksToBounds = true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        if PFUser.currentUser() != nil {
            getCurrentProfile()
        }
        else {
            scrollView.hidden = true
        }
        
    }
    
    func getCurrentProfile() {

        let ProfileQuery = Profile.query()
        ProfileQuery!.whereKey("user", equalTo: PFUser.currentUser()!)
        ProfileQuery!.findObjectsInBackgroundWithBlock {(result: [PFObject]?, error: NSError?) -> Void in

        
        let userImageFile = result![0]["imageFile"] as! PFFile
        
            userImageFile.getDataInBackgroundWithBlock{
                (imageData: NSData?, error: NSError?) -> Void in
                if error == nil {
                    if let image = UIImage(data: imageData!) {
                        self.profileImageView.image = image
                    }
                }
            }
            
        self.nameLabel.text = "\(result![0]["first_name"]) \(result![0]["last_name"])"
        self.countryLabel.text = "\(result![0]["country"])"
        self.lookingForLabel.text = "\(result![0]["looking_for"])"
        self.offeringLabel.text = "\(result![0]["offering"])"
        self.summaryLabel.text = "\(result![0]["summary"])"
        }
    }
    
    // MARK: - Actions
    

    @IBAction func loginCreateAction(sender: AnyObject) {
        performSegueWithIdentifier(StoryBoard.segueToLoginSignUp, sender: nil)
        
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

}
