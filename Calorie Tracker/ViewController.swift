//
//  ViewController.swift
//  Calorie Tracker
//
//  Created by CISstudent on 11/18/16.
//  Copyright (c) 2016 rase. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var genderSegmentControl: UISegmentedControl!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var bmrLabel: UILabel!
    
    let userPreferences = NSUserDefaults.standardUserDefaults()
    var genderValue: Int = 0
    var heightValue: Double = 0
    var weightValue: Double = 0
    var ageValue: Double = 0
    var BMR: Double = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        loadUserSettings()
    }
    
    func loadUserSettings() {
        
        if let name = userPreferences.stringForKey("userName") {
            nameTextField.text = name
        } else {
            nameTextField.text = ""
        }
        
        if let gender = userPreferences.integerForKey("userGender") as Int? {
            genderSegmentControl.selectedSegmentIndex = gender
            genderValue = gender
        } else {
            genderSegmentControl.selectedSegmentIndex = 0
        }
        
        if let height = userPreferences.doubleForKey("userHeight") as Double? {
            if height != 0 {
                heightTextField.text = "\(height)"
                heightValue = height
            } else {
                heightTextField.text = ""
            }
        }
        
        if let weight = userPreferences.doubleForKey("userWeight") as Double? {
            if weight != 0 {
                weightTextField.text = "\(weight)"
                weightValue = weight
            } else {
                weightTextField.text = ""
            }
        }
        
        if let age = userPreferences.doubleForKey("userAge") as Double? {
            if age != 0 {
                ageTextField.text = "\(age)"
                ageValue = age
            } else {
                ageTextField.text = ""
            }
        }
        
        calculateBMR()
    }
    
    func calculateBMR() {
        if heightValue == 0.0 && weightValue == 0.0 && ageValue == 0 {
            userPreferences.setInteger(2000, forKey: "userBMR")
            bmrLabel.text = "Basal Metabolic Rate is 2000 Calories/day"
        } else {
            if genderValue == 0 {
                BMR = 66 + (6.25 * weightValue) + (12.7 * heightValue) - (6.76 * ageValue)
            } else if genderValue == 1 {
                BMR = 655 + (4.35 * weightValue) + (4.7 * heightValue) - (4.68 * ageValue)
            }
            
            bmrLabel.text = "Basal Metabolic Rate is \(BMR) Calories/day"
        }
    }
    
    @IBAction func updateUserSettings(sender: AnyObject) {
        //update user settings
        if nameTextField.text != "" {
            userPreferences.setValue(nameTextField.text, forKey: "userName")
        }
        
        if heightTextField.text != "" {
            userPreferences.setDouble((heightTextField.text as NSString).doubleValue, forKey: "userHeight")
        }
        
        if weightTextField.text != "" {
            userPreferences.setDouble((weightTextField.text as NSString).doubleValue, forKey: "userWeight")
        }
        
        if ageTextField.text != "" {
            userPreferences.setDouble((ageTextField.text as NSString).doubleValue, forKey: "userAge")
        }
        
        userPreferences.setInteger(genderSegmentControl.selectedSegmentIndex, forKey: "userGender")
        
        loadUserSettings()
    }
}

