//
//  CompleteProfileInfoViewController.swift
//  messyhat-ios
//
//  Created by kelvinfok on 25/7/16.
//  Copyright © 2016 kelvinfok. All rights reserved.
//

import UIKit
import Parse

class CompleteProfileInfoViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {


    var lookingForPickerOptions = ["A", "B", "C"]
    var offeringPickerOptions = ["V", "W", "X", "Y", "Z"]
    
    var lookingForValue: String?
    var offeringValue: String?
    
    struct StoryBoard {
        static let segueToExchangeRegistration = "completeExchangeRegistration"
    }
    
    var pickerView = UIPickerView()

    @IBOutlet weak var countryTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var dayOfBirth: UITextField!
    
    @IBOutlet weak var monthOfBirth: UITextField!
    
    @IBOutlet weak var yearOfBirth: UITextField!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        
    }

    
    @IBAction func continueBasicRegistration(sender: AnyObject) {
        
        self.performSegueWithIdentifier(StoryBoard.segueToExchangeRegistration, sender: category)
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
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return Categories.subCategories.count
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView.tag == 1) {
            lookingForValue = Categories.subCategories[row]
        }
        else if (pickerView.tag == 2) {
            offeringValue = Categories.subCategories[row]
        }
    }


    
}
