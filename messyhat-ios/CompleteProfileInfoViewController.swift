//
//  CompleteProfileInfoViewController.swift
//  messyhat-ios
//
//  Created by kelvinfok on 25/7/16.
//  Copyright © 2016 kelvinfok. All rights reserved.
//

import UIKit
import Parse

class CompleteProfileInfoViewController: UIViewController  {

    @IBAction func buttonContinue(sender: AnyObject) {
        saveDetails()
    }
    var pickerOptions = ["A", "B", "C"]
    
    var lookingForValue: String?
    var offeringValue: String?
    

    @IBOutlet weak var countryTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var dayOfBirth: UITextField!
    
    @IBOutlet weak var monthOfBirth: UITextField!
    
    @IBOutlet weak var yearOfBirth: UITextField!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }

    
    func saveDetails() {
        

//        let profile = PFObject(className: "Profile")
//        profile["first_name"] = firstNameTextField.text
//        profile["last_name"] = lastNameTextField.text
//        profile["country"] = countryTextField.text
//        profile["user"] = PFUser.currentUser()
//        // profile["date_of_birth"] = "07/07/1985"
//        profile.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
//            if success == true {
//                print("Object has been saved.")
//            } else {
//                print(error)
//            }
//        }
        
    }
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
