//
//  CompleteProfileInfoViewController.swift
//  messyhat-ios
//
//  Created by kelvinfok on 25/7/16.
//  Copyright © 2016 kelvinfok. All rights reserved.
//

import UIKit
import Parse

class CompleteProfileInfoViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    var newProfile = Profile()
    
    struct StoryBoard {
        static let segueToExchangeRegistration = "segueToExchangeRegistration"
        static let segueToSummaryRegistration = "segueToSummaryRegistration"
    }
    
    var pickerView = UIPickerView()

    @IBOutlet weak var countryTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var yearOfBirth: UITextField!
    
    @IBOutlet weak var summaryTextView: UITextView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        if summaryTextView != nil {
            self.summaryTextView.layer.cornerRadius = 10
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        print("View Did Appear")
        print(newProfile)
    }
    
    @IBAction func continueBasicRegistration(sender: AnyObject) {
        
        newProfile.first_name = firstNameTextField.text
        newProfile.last_name = lastNameTextField.text
        newProfile.country = countryTextField.text
        
        self.performSegueWithIdentifier(StoryBoard.segueToExchangeRegistration, sender: self)
    }
    
    
    @IBAction func continueExchangeRegistration(sender: AnyObject) {
        
        self.performSegueWithIdentifier(StoryBoard.segueToSummaryRegistration, sender: self)
    }
    
    
    @IBAction func saveProfile(sender: AnyObject) {
        
        newProfile.summary = summaryTextView.text
        newProfile.user = PFUser.currentUser()
        newProfile.saveProfile()
        print("Profile saved!")
        self.navigationController?.popToRootViewControllerAnimated(true)
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
            newProfile.looking_for = Categories.subCategories[row]
            print(newProfile.looking_for)
        }
        else if (pickerView.tag == 2) {
            newProfile.offering = Categories.subCategories[row]
            print(newProfile.offering)
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return Categories.subCategories[row]
    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let destinationController = segue.destinationViewController as! CompleteProfileInfoViewController
        destinationController.newProfile = newProfile
    }
    
    
    // MARK: Keyboard Control
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}
