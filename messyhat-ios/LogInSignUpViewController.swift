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

class LogInSignUpViewController: PFLogInViewController {
    
    struct StoryBoard {
        static let completeProfile = "segueToBasicRegistration"
        static let title = "MessyHat"
    }
    
    var profile = [Profile]()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        title = StoryBoard.title
        let signUpVC = PFSignUpViewController()
        signUpVC.delegate = self
        self.delegate = self
        self.signUpController = signUpVC
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
}

extension LogInSignUpViewController : PFSignUpViewControllerDelegate {
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        dismissViewControllerAnimated(true, completion: nil)
        print("Sign Up success!")
        checkProfileIsCompleted()
    }
}


extension LogInSignUpViewController : PFLogInViewControllerDelegate {
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) -> Void{
        checkProfileIsCompleted()
    }
    
    func logInViewController(logInController: PFLogInViewController, didFailToLogInWithError error: NSError?) {
        print(error)
    }
}
