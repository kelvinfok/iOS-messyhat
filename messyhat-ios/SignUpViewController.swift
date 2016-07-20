//
//  SignUpViewController.swift
//  messyhat-ios
//
//  Created by kelvinfok on 21/7/16.
//  Copyright © 2016 kelvinfok. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pickerSeekingToLearn: UIPickerView!

    var subCategory = ["Code - Web","Code - Mobile", "Code - Game"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerSeekingToLearn.delegate = self
        pickerSeekingToLearn.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return subCategory[row]
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return subCategory.count
    }
    
    internal func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

}
