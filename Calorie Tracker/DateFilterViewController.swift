//
//  DateFilterViewController.swift
//  Calorie Tracker
//
//  Created by cisstudent on 11/28/16.
//  Copyright (c) 2016 rase. All rights reserved.
//

import UIKit

class DateFilterViewController: UIViewController {

    var selectedDate: NSDate?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    @IBOutlet weak var datePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedDate = NSDate()
    }

    @IBAction func selectDateForFilter(sender: AnyObject) {
        selectedDate = datePicker.date
    }
    
    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "dateFilterSegue" {
            if let destinationVC = segue.destinationViewController as? TrackerTableViewController {
                destinationVC.filterDate = selectedDate!
            }
        }
    }
    */
}
