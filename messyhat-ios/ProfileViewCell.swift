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
            self.profileName.text = "\(profile.first_name!) \(profile.last_name!)"
            self.profileSummary.text = "Singapore"
            
            
            
            let userImageFile = profile.imageFile
            
            userImageFile!.getDataInBackgroundWithBlock{(imageData: NSData?, error: NSError?) -> Void in
                if error == nil {
                    if let image = UIImage(data: imageData!) {
                        self.profileImageView.image = image
                        
                    }
                }
            }
            
            
            
            self.layer.masksToBounds = true
            self.layer.cornerRadius = 3.0
        }
       
        

    }
}
