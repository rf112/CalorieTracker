//
//  AddEntryViewController.swift
//  Calorie Tracker
//
//  Created by cisstudent on 11/26/16.
//  Copyright (c) 2016 rase. All rights reserved.
//

import UIKit
import CoreData

class AddEntryViewController: UIViewController {

    @IBOutlet weak var entryNameTextField: UITextField!
    @IBOutlet weak var entryDescriptionTextField: UITextField!
    @IBOutlet weak var entryCaloriesTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addEntry(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        let entity =  NSEntityDescription.entityForName("Entry", inManagedObjectContext:managedContext)
        let entry = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        var error: NSError?
        
        var selectedDate = datePicker.date
        
        if entryNameTextField.text == "" {
            let alertController = UIAlertController(title: "Missing Name", message: "Please enter a name", preferredStyle: .Alert)
            let OKAction = UIAlertAction (
                title: "Ok",
                style: UIAlertActionStyle.Cancel,
                handler: nil
            )
            alertController.addAction(OKAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        } else if entryDescriptionTextField.text == "" {
            let alertController = UIAlertController(title: "Missing Description", message: "Please enter a description", preferredStyle: .Alert)
            let OKAction = UIAlertAction (
                title: "Ok",
                style: UIAlertActionStyle.Cancel,
                handler: nil
            )
            alertController.addAction(OKAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        } else if entryCaloriesTextField.text == "" {
            let alertController = UIAlertController(title: "Missing Calories", message: "Please enter a calorie value", preferredStyle: .Alert)
            let OKAction = UIAlertAction (
                title: "Ok",
                style: UIAlertActionStyle.Cancel,
                handler: nil
            )
            alertController.addAction(OKAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        } else {
        
            var netCalories = (entryCaloriesTextField.text as NSString).doubleValue
        
            entry.setValue(selectedDate, forKey: Keys.dateKey)
            entry.setValue(entryNameTextField.text, forKey: Keys.nameKey)
            entry.setValue(entryDescriptionTextField.text, forKey: Keys.descKey)
            entry.setValue(netCalories, forKey: Keys.calKey)
        
            managedContext.save(&error)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
