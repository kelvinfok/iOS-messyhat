//
//  ParseHelper.swift
//  messyhat-ios
//
//  Created by kelvinfok on 21/7/16.
//  Copyright © 2016 kelvinfok. All rights reserved.
//

import Foundation
import Parse


class ParseHelper {

    
    static func ProfilesRequestForCurrentCategory(categoryName: String, completionBlock: PFQueryArrayResultBlock) {
        
        let profilesCollectionQuery = PFQuery(className: "Profile")
        profilesCollectionQuery.whereKey("offering", equalTo: categoryName)

        profilesCollectionQuery.findObjectsInBackgroundWithBlock(completionBlock)
    }
    
}