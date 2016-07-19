//
//  ProfileCollectionViewCell.swift
//  messyhat-ios
//
//  Created by kelvinfok on 20/7/16.
//  Copyright © 2016 kelvinfok. All rights reserved.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var profileDescription: UILabel!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var category: Category? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 3.0
        profileNameLabel.text = "Kelmo"
        // categoryImageView.image = category?.image
        // categoryTitleLabel.text = category?.title
    }
}
