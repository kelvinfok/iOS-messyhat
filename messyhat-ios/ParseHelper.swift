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
        
        let profilesCollectionQuery = PFQuery(className: Profile.parseClassName())
        profilesCollectionQuery.whereKey("offering", equalTo: categoryName)
        profilesCollectionQuery.includeKey("user")
        profilesCollectionQuery.findObjectsInBackgroundWithBlock(completionBlock)
    }
    
    
    static func SingleProfileRequestForCurrentCategory(categoryName: String, completionBlock: PFQueryArrayResultBlock) {
        
        let profilesCollectionQuery = PFQuery(className: Profile.parseClassName())
        profilesCollectionQuery.whereKey("offering", equalTo: categoryName)
        
        profilesCollectionQuery.findObjectsInBackgroundWithBlock(completionBlock)
    }
    
    
    
}