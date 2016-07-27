//
//  CompleteProfileInfoViewController.swift
//  messyhat-ios
//
//  Created by kelvinfok on 25/7/16.
//  Copyright © 2016 kelvinfok. All rights reserved.
//

import UIKit
import Parse

class CompleteProfileInfoViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var newProfile = Profile()
    var countrySelected: String?
    var dateOfBirthSelected: NSDate?
    
    var countryOptions = ["Singapore", "Malaysia", "Indonesia", "Vietnam", "Thailand", "Philippines"]
    
    struct StoryBoard {
        static let segueToExchangeRegistration = "segueToExchangeRegistration"
        static let segueToSummaryRegistration = "segueToSummaryRegistration"
    }
    
    var pickerView = UIPickerView()
    

    @IBOutlet weak var uploadPreviewImage: UIImageView!
    
    @IBOutlet weak var dateOfBirthDatePicker: UIDatePicker!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var countryPickerView: UIPickerView!
    
    @IBOutlet weak var summaryTextView: UITextView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        if dateOfBirthDatePicker != nil {
            
            dateOfBirthDatePicker.addTarget(self, action: #selector(CompleteProfileInfoViewController.selectDate(_:)), forControlEvents: UIControlEvents.ValueChanged)
        }
        
        if summaryTextView != nil {
            self.summaryTextView.layer.cornerRadius = 10
        }
    }
    
    func selectDate(dateOfBirthDatePicker: UIDatePicker) {
        dateOfBirthSelected = dateOfBirthDatePicker.date
        print("\(dateOfBirthDatePicker.date)")
        print("DOB IS: \(dateOfBirthSelected)")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        print("View Did Appear")
        print(newProfile)
    }
    
    // MARK: Actions
    
    
    
    @IBAction func addProfilePicture(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.allowsEditing = false
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func continueBasicRegistration(sender: AnyObject) {
        
        newProfile.first_name = firstNameTextField.text
        newProfile.last_name = lastNameTextField.text
        //newProfile.country = countrySelected
        //newProfile.date_of_birth = dateOfBirthSelected!
        
        self.performSegueWithIdentifier(StoryBoard.segueToExchangeRegistration, sender: self)
    }
    
    
    @IBAction func continueExchangeRegistration(sender: AnyObject) {
        
        self.performSegueWithIdentifier(StoryBoard.segueToSummaryRegistration, sender: self)
    }
    
    // MARK: Saving Of Data
    
    @IBAction func saveProfile(sender: AnyObject) {
        
        newProfile.summary = summaryTextView.text
        newProfile.user = PFUser.currentUser()
        newProfile.saveProfile()
        print("Profile saved!")
        self.navigationController?.popToRootViewControllerAnimated(true)
    }

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Image Picker Controls
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        uploadPreviewImage.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Picker View Settings
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var arrayCountPlacer = []
        if (pickerView.tag == 0) {
            arrayCountPlacer = countryOptions
        }
        else {
            arrayCountPlacer = Categories.subCategories
        }
        return arrayCountPlacer.count
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView.tag == 0) {
            countrySelected = countryOptions[row]
            print(countryOptions[row])
        }
        else if (pickerView.tag == 1) {
            newProfile.looking_for = Categories.subCategories[row]
            print(newProfile.looking_for)
        }
        else if (pickerView.tag == 2) {
            newProfile.offering = Categories.subCategories[row]
            print(newProfile.offering)
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        var arrayOptionsPlacer = []
        
        if (pickerView.tag == 0) {
            arrayOptionsPlacer =  self.countryOptions
        }
        else {
            arrayOptionsPlacer = Categories.subCategories
        }
        return (arrayOptionsPlacer[row] as! String)
    }
    
    // MARK: Segue


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
