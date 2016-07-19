//
//  category.swift
//  messyhat-ios
//
//  Created by kelvinfok on 19/7/16.
//  Copyright © 2016 kelvinfok. All rights reserved.
//

import UIKit

class Category
{
    var title: String
    var image: UIImage
    var section: String
    
    init(title: String, image: UIImage, section: String)
    {
        self.title = title
        self.image = image
        self.section = section
    }
    
    convenience init(copies category: Category)
    {
        self.init(title: category.title, image: category.image, section: category.section)
    }
}
