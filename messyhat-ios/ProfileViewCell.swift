//
//  ProfileCollectionViewCell.swift
//  messyhat-ios
//
//  Created by kelvinfok on 20/7/16.
//  Copyright © 2016 kelvinfok. All rights reserved.
//

import UIKit

class ProfileViewCell: UICollectionViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var profileName: UILabel!
    
    @IBOutlet weak var profileSummary: UILabel!
    
    var profile: Profile? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        
        if let profile = profile {
            self.profileName.text = profile.user?.email
            self.profileSummary.text = profile.offering!
            self.layer.masksToBounds = true
            self.layer.cornerRadius = 3.0
        }
       
        

    }
}
