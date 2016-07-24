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
    @IBOutlet weak var profileSelfSummary: UILabel!
    @IBOutlet weak var ageLocation: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        self.profileSelfSummary.text = profiles.summary
        self.profileNameLabel.text = profiles.first_name
        self.offering.text = "In Exchange: \(profiles.offering!) lessons"
        self.looking_for.text = "Seeking: \(profiles.looking_for!) lessons"
        self.ageLocation.text = "\(profiles.country!)"
    }

}
