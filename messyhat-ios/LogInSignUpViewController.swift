//
//  LogInSignUpViewController.swift
//  messyhat-ios
//
//  Created by kelvinfok on 25/7/16.
//  Copyright © 2016 kelvinfok. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import Bolts

class LogInSignUpViewController: PFLogInViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {
    
    var backgroundImage : UIImageView!
    var viewsToAnimate: [UIView!]!
    var viewsFinalYPosition : [CGFloat]!
    
    struct StoryBoard {
        static let completeProfile = "segueToBasicRegistration"
        static let title = "MessyHat"
    }
    
    var profile = [Profile]()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setUI()
        setParse()
        setBG()
        setLogo()
        setButton()
        // self.signUpController = SignUpViewController()
    }
    
    func setParse() {
        let signUpViewController = PFSignUpViewController()
        signUpViewController.delegate = self
        self.delegate = self
        self.signUpController = signUpViewController
    }
    
    func setButton() {
        
        logInView?.logInButton?.setBackgroundImage(nil, forState: .Normal)
        logInView?.logInButton?.backgroundColor = UIColor(red: 52/255, green: 191/255, blue: 73/255, alpha: 0.95)
        logInView?.passwordForgottenButton?.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        customizeButton(logInView?.signUpButton!)
    }
    
    
    func customizeButton(button: UIButton!) {
        
        button.setBackgroundImage(nil, forState: .Normal)
        button.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.2)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.whiteColor().CGColor
    }
    
    
    func setBG() {
        
        backgroundImage = UIImageView(image: UIImage(named: "work"))
        backgroundImage.contentMode = UIViewContentMode.ScaleAspectFill
        self.logInView!.insertSubview(backgroundImage, atIndex: 0)
    }
    
    func setLogo() {
        
        let logo = UILabel()
        logo.text = "MessyHat"
        logo.textColor = UIColor.whiteColor()
        logo.font = UIFont(name: "Lato", size: 65)
        logInView?.logo = logo
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    
        backgroundImage.frame = CGRectMake( 0,  0,  self.logInView!.frame.width,  self.logInView!.frame.height)
        
        logInView!.logo!.sizeToFit()
        let logoFrame = logInView!.logo!.frame
        logInView!.logo!.frame = CGRectMake(logoFrame.origin.x, logInView!.usernameField!.frame.origin.y - logoFrame.height - 16, logInView!.frame.width,  logoFrame.height)
    }
    
    
    func setUI() {
        self.tabBarController?.tabBar.hidden = true
        title = StoryBoard.title
    }
    
    
    func showCategoryVC() {
        self.navigationController?.popToRootViewControllerAnimated(true)
        print("Show Category")
    }
    
    func checkProfileIsCompleted() {
        
        print(PFUser.currentUser())
        
        let ProfileQuery = Profile.query()
        ProfileQuery!.whereKey("user", equalTo: PFUser.currentUser()!)
        ProfileQuery!.findObjectsInBackgroundWithBlock {(result: [PFObject]?, error: NSError?) -> Void in
            if result!.count == 0 {
                self.performSegueWithIdentifier(StoryBoard.completeProfile, sender: self)
                print("User has not completed Profile. Hence directing to CompleteProfileVC")
            }
            else {
                print("User has completed Profile. Redirect to CategoriesVC")                
                self.showCategoryVC()
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueToBasicRegistration" {
            let destinationController = segue.destinationViewController as! CompleteProfileInfoViewController
            destinationController.currentUserEmail = "\(PFUser.currentUser()!.email!)"
        }
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        dismissViewControllerAnimated(true, completion: nil)
        print("Sign Up success!")
        checkProfileIsCompleted()
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) -> Void{
        checkProfileIsCompleted()
    }
    
    func logInViewController(logInController: PFLogInViewController, didFailToLogInWithError error: NSError?) {
        print(error)
    }
    
}

