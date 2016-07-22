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
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileSelfSummary: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getProfile()
        title = "\(profiles["summary"])"
    }
    
    func getProfile() {
        
    }

}
