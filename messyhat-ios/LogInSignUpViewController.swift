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

    override func viewDidLoad() {
        
        super.viewDidLoad()
        title = "MessyHat"
        let signUpVC = PFSignUpViewController()
        signUpVC.delegate = self
        self.delegate = self
        self.signUpController = signUpVC
    }
    
    func showCategoryVC() {
        self.navigationController?.popToRootViewControllerAnimated(true)
        print("Show Category")
    }
}

extension LogInSignUpViewController : PFSignUpViewControllerDelegate {
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        dismissViewControllerAnimated(true, completion: nil)
        print("Sign Up success!")
        showCategoryVC()
    }
}


extension LogInSignUpViewController : PFLogInViewControllerDelegate {
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) -> Void{
        showCategoryVC()
    }
    
    func logInViewController(logInController: PFLogInViewController, didFailToLogInWithError error: NSError?) {
        print(error)
    }
}
