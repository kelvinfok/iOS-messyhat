//
//  Profile.swift
//  messyhat-ios
//
//  Created by kelvinfok on 20/7/16.
//  Copyright © 2016 kelvinfok. All rights reserved.
//

import Foundation
import Parse


class Profile : PFObject, PFSubclassing {
    
    @NSManaged var imageFile: PFFile?
    @NSManaged var user: PFUser?
    @NSManaged var summary: String?
    @NSManaged var looking_for: String?
    @NSManaged var offering: String?
    @NSManaged var first_name: String?
    @NSManaged var country: String?
    @NSManaged var profileCompleted: Bool
    
    
    static func parseClassName() -> String {
        return "Profile"
    }
    
    override init () {
        super.init()
    }
    
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            // inform Parse about this subclass
            self.registerSubclass()
        }
    }
    
    
}

extension String {
    func firstCharacterUpperCase() -> String {
        let lowercaseString = self.lowercaseString
        
        return lowercaseString.stringByReplacingCharactersInRange(lowercaseString.startIndex...lowercaseString.startIndex, withString: String(lowercaseString[lowercaseString.startIndex]).uppercaseString)
    }
}
