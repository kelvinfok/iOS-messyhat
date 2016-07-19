//
//  CategoryCollectionViewCell.swift
//  messyhat-ios
//
//  Created by kelvinfok on 19/7/16.
//  Copyright © 2016 kelvinfok. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var categoryTitleLabel: UILabel!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var categoryImageView: UIImageView!
    
    var category: Category? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 3.0
        categoryImageView.image = category?.image
        categoryTitleLabel.text = category?.title
    }
}
