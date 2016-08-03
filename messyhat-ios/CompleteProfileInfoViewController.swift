//
//  CompleteProfileInfoViewController.swift
//  messyhat-ios
//
//  Created by kelvinfok on 25/7/16.
//  Copyright © 2016 kelvinfok. All rights reserved.
//

import UIKit
import Parse

class CompleteProfileInfoViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    var newProfile = Profile()
    var countrySelected: String?
    var dateOfBirthSelected: NSDate?
    var currentUserEmail: String?
    
    var countryOptions = ["Singapore", "Malaysia", "Indonesia", "Vietnam", "Thailand", "Philippines"]
    
    struct StoryBoard {
        static let segueToExchangeRegistration = "segueToExchangeRegistration"
        static let segueToSummaryRegistration = "segueToSummaryRegistration"
        static let segueToTerms = "segueToTerms"
        static let segueToAgreement = "segueToAgreement"
        static let segueToMyProfile = "segueToMyProfile"
    }
    
    var pickerView = UIPickerView()
    
    @IBOutlet weak var completeButton: UIButton!

    @IBOutlet weak var uploadPreviewImage: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var summaryTextView: UITextView!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        if (completeButton != nil) {
            completeButton.layer.cornerRadius = 5.0
            completeButton.layer.masksToBounds = true
        }

        if emailTextField != nil {
            emailTextField.text = currentUserEmail!
        }
        
        setProfileAvatarGesture()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(CompleteProfileInfoViewController.tap(_:)))
        view.addGestureRecognizer(tapGesture)
        
        // self.hideKeyboard()
        
        if summaryTextView != nil {
            self.summaryTextView.layer.cornerRadius = 10
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        print("View Did Appear")
        print(newProfile)
    }
    
    func setProfileAvatarGesture() {
        let tapAvatarGestureRecognizer = UITapGestureRecognizer(target:self, action: #selector(CompleteProfileInfoViewController.avatarTapped))
        uploadPreviewImage.userInteractionEnabled = true
        uploadPreviewImage.addGestureRecognizer(tapAvatarGestureRecognizer)
    }
    
    func avatarTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.allowsEditing = false
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func openImagePicker() {

    }
    // MARK: Actions
    
    
    @IBAction func readMoreButton(sender: AnyObject) {
        self.performSegueWithIdentifier(StoryBoard.segueToAgreement, sender: self)
    }
    
    @IBAction func addProfilePicture(sender: AnyObject) {


    }
    
    // MARK: Continue Button
    
    @IBAction func continueBasicRegistration(sender: AnyObject) {
        
        newProfile.first_name = firstNameTextField.text
        newProfile.last_name = lastNameTextField.text
        let imageData = UIImagePNGRepresentation(self.uploadPreviewImage.image!)
        let parseImageFile = PFFile(name: "upload_image.png", data: imageData!)
        newProfile.imageFile = parseImageFile
        
        self.performSegueWithIdentifier(StoryBoard.segueToExchangeRegistration, sender: self)
    }
    
    
    @IBAction func continueExchangeRegistration(sender: AnyObject) {
        
        if (newProfile.looking_for == nil) {
            newProfile.looking_for = Categories.subCategories[0]
        }
        if (newProfile.offering == nil) {
            newProfile.offering = Categories.subCategories[0]
        }
        
        self.performSegueWithIdentifier(StoryBoard.segueToSummaryRegistration, sender: self)
    }
    
    // MARK: Saving Of Data
    
    @IBAction func saveProfile(sender: AnyObject) {
        
        newProfile.summary = summaryTextView.text
        newProfile.user = PFUser.currentUser()
        
        newProfile.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if success == true {
                print("Object has been saved.")
                self.navigationController?.popToRootViewControllerAnimated(true)
            }
            else {
                print(error)
            }
        }
     
        
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
        if segue.identifier != StoryBoard.segueToAgreement {
            let destinationController = segue.destinationViewController as! CompleteProfileInfoViewController
            destinationController.newProfile = newProfile
        }
    }
    
    @IBAction func unwindToCompleteProfileInfoViewController(segue: UIStoryboardSegue) {
    }
    
    // MARK: Keyboard Control
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField == firstNameTextField || textField == lastNameTextField {
            scrollView.setContentOffset(CGPointMake(0, 300), animated: true)
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        scrollView.setContentOffset(CGPointMake(0, 0), animated: true)
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        scrollView.setContentOffset(CGPointMake(0, 300), animated: true)
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        scrollView.setContentOffset(CGPointMake(0, 0), animated: true)
    }
    
    func tap(gesture: UITapGestureRecognizer) {
        
        if self.firstNameTextField != nil {
            firstNameTextField.resignFirstResponder()
        }
        if self.lastNameTextField != nil {
            lastNameTextField.resignFirstResponder()
        }
        if self.summaryTextView != nil {
            summaryTextView.resignFirstResponder()
        }
    }
    
    
}