//
//  SectionHeaderView.swift
//  messyhat-ios
//
//  Created by kelvinfok on 19/7/16.
//  Copyright © 2016 kelvinfok. All rights reserved.
//

import UIKit

class SectionHeaderView: UICollectionReusableView
{

    @IBOutlet weak var sectionLabel: UILabel!
    
    var category: Category? {
        didSet {
            sectionLabel.text = category?.section.uppercaseString
        }
    }
    
    
}