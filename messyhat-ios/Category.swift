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
    var key: String
    
    init(title: String, key: String, image: UIImage, section: String)
    {
        self.title = title
        self.image = image
        self.section = section
        self.key = key
    }
    
    convenience init(copies category: Category)
    {
        self.init(title: category.title, key: category.key, image: category.image, section: category.section)
    }
}
