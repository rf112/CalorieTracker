//
//  TrackerTableViewController.swift
//  Calorie Tracker
//
//  Created by Adam on 11/24/16.
//  Copyright (c) 2016 rase. All rights reserved.
//

import UIKit
import CoreData

class TrackerTableViewController: UITableViewController {

    // Keys for accessing Info from core date - Adam
    
    // Core data entries stored in an array - Adam
    var entries = [NSManagedObject]()
    var entriesByDate = [NSManagedObject]()
    
    // For formatting dates into strins - Adam
    let dateFormatter = NSDateFormatter()
    
    var filterDate: NSDate?
    
    var error: NSError?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        fetchEntries()
        filterEntriesByDate()
    }
    
    func fetchEntries() {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Entry")
        let sortDescriptor = NSSortDescriptor(key: Keys.dateKey, ascending: false, selector: "localizedCaseInsensitiveCompare:")
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let results = managedContext?.executeFetchRequest(fetchRequest, error: &error)

        entries = results as [NSManagedObject]
    }
    
    func filterEntriesByDate(selectedDate: NSDate = NSDate()) {
        
        entriesByDate = entries.filter() {
            var entryNumbers = self.getDateComponentsFromDate($0.valueForKey(Keys.dateKey) as NSDate)
            var selectedDateNumbers = self.getDateComponentsFromDate(selectedDate)
            
            return (
                entryNumbers["day"] == selectedDateNumbers["day"] &&
                entryNumbers["month"] == selectedDateNumbers["month"] &&
                entryNumbers["year"] == selectedDateNumbers["year"]
            )
        }
        
        entriesByDate = entries
    }
    
    func getDateComponentsFromDate(date: NSDate) -> [String : NSNumber] {
        let calendar = NSCalendar.currentCalendar()
        
        var dateNumbers: [String : NSNumber] = [
            "month" : calendar.component(.CalendarUnitMonth, fromDate: date),
            "day"   : calendar.component(.CalendarUnitDay, fromDate: date),
            "year"  : calendar.component(.CalendarUnitYear, fromDate: date)
        ]
        return dateNumbers
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entriesByDate.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "EntryCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as EntryCell
        
        let entry = entriesByDate[indexPath.row]
        
        // Gets the date from inside core data - Adam
        var entryDate = entry.valueForKey(Keys.dateKey) as? NSDate
        
        // Formats date for display on the tableview - Adam
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        var convertedDate = dateFormatter.stringFromDate(entryDate!)
        
        // Sets the labels for each entry in entries - Adam
        cell.dateLabel.text = convertedDate
        cell.nameLabel.text = entry.valueForKey(Keys.nameKey) as? String
        cell.descriptionLabel.text = entry.valueForKey(Keys.descKey) as? String
        cell.calorieLabel.text = "\(entry.valueForKey(Keys.calKey) as Double!)"
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
            let managedContext = appDelegate.managedObjectContext
            managedContext?.deleteObject(entriesByDate[indexPath.row] as NSManagedObject)
            entriesByDate.removeAtIndex(indexPath.row)
            managedContext?.save(&error)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
}
