class Code_Bank {

    //        do {
    //            try PFUser.logInWithUsername("test", password: "test")
    //        } catch {
    //            print("Unable to log in")
    //        }
    //
    //        if let currentUser = PFUser.currentUser() {
    //            print("1. \(currentUser.username!) user logged in successfully")
    //        } else {
    //            print("No logged in user :(")
    //        }


    /* Saving object
     
     let profile = PFObject(className: "Profile")
     profile["looking_for"] = "Coding Classes"
     profile["offering"] = "Sports Classes"
     profile["summary"] = "I am very proficient."
     profile["user"] = PFUser.currentUser()
     profile.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
     if success == true {
     print("Object has been saved.")
     } else {
     print(error)
     }
     }
     */
    
    // MARK: Querying
    
    //        let ProfileQuery = Profile.query()
    //
    //        ProfileQuery!.whereKey("user", equalTo: PFUser.currentUser()!)
    //
    //        ProfileQuery!.findObjectsInBackgroundWithBlock {(result: [PFObject]?, error: NSError?) -> Void in
    //
    //            print(result)
    //            print("\n")
    //            print(PFUser.currentUser())
    //
    //            for summary in result! {
    //                print("Summary is .. \(summary["summary"])")
    //            }
    //        }


    // if let pageViewController = storyboard?.instantiateViewControllerWithIdentifier("PageViewController") {
    // self.presentViewController(pageViewController, animated: true, completion: nil)


}
