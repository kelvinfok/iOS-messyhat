//
//  ParseHelper.swift
//  messyhat-ios
//
//  Created by kelvinfok on 21/7/16.
//  Copyright © 2016 kelvinfok. All rights reserved.
//

import Foundation
import Parse

// 1
class ParseHelper {
    
    // 2
    static func ProfilesRequestForCurrentCategory(completionBlock: PFQueryArrayResultBlock, category: String) {
        
        let profilesCollectionQuery = PFQuery(className: "Profile")
        profilesCollectionQuery.whereKey("offering", equalTo: category)

        profilesCollectionQuery.findObjectsInBackgroundWithBlock(completionBlock)
    }
    
}