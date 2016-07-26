//
//  MyProfileViewController.swift
//  messyhat-ios
//
//  Created by kelvinfok on 20/7/16.
//  Copyright © 2016 kelvinfok. All rights reserved.
//

import UIKit
import Parse

class MyProfileViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lookingForLabel: UILabel!
    @IBOutlet weak var offeringLabel: UILabel!
    @IBOutlet weak var summaryLabel: UITextView!

    var profiles = Profile()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        getCurrentProfile()
    }
    
    func getCurrentProfile() {
        
        let ProfileQuery = Profile.query()
        ProfileQuery!.whereKey("user", equalTo: PFUser.currentUser()!)
        ProfileQuery!.findObjectsInBackgroundWithBlock {(result: [PFObject]?, error: NSError?) -> Void in
            
        self.nameLabel.text = "\(result![0]["first_name"]) \(result![0]["last_name"])"
        self.countryLabel.text = "\(result![0]["country"])"
        self.lookingForLabel.text = "\(result![0]["looking_for"])"
        self.offeringLabel.text = "\(result![0]["offering"])"
        self.summaryLabel.text = "\(result![0]["summary"])"
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

}
