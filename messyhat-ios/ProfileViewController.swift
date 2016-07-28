//
//  ProfileViewController.swift
//  messyhat-ios
//
//  Created by kelvinfok on 20/7/16.
//  Copyright © 2016 kelvinfok. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var profiles = Profile()
    
    @IBOutlet weak var offering: UILabel!
    @IBOutlet weak var looking_for: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileSelfSummary: UITextView!
    @IBOutlet weak var ageLocation: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        updateUI()
    }
    
    
    func updateUI() {
    
    title = "Profile"
    self.profileSelfSummary.text = profiles.summary
    self.profileNameLabel.text = profiles.first_name
    self.offering.text = "\(profiles.offering!)"
    self.looking_for.text = "\(profiles.looking_for!)"
    
    // Load Images
    
    let userImageFile = profiles.imageFile
    
    userImageFile!.getDataInBackgroundWithBlock{(imageData: NSData?, error: NSError?) -> Void in
        if error == nil {
            if let image = UIImage(data: imageData!) {
            self.profileImageView.image = image
            }
        }
    }
    
    
    }

}
