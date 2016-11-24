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
    let dateKey = "date"
    let nameKey = "entryName"
    let descKey = "entryDescription"
    let calKey = "netCalories"
    
    // Core data entries stored in an array - Adam
    var entries = [NSManagedObject]()
    
    // For formatting dates into strins - Adam
    let dateFormatter = NSDateFormatter()
    
    // Gets today's date (I think) - Adam
    var todayDate = NSDate()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        loadTestdata()
    }
    
    // Loads some test date for viewing - Adam
    // Marked for deletion once creation is implemented
    func loadTestdata() {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        let entity =  NSEntityDescription.entityForName("Entry", inManagedObjectContext:managedContext)
        let entry1 = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        let entry2 = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        var error: NSError?
        
        //workout
        entry1.setValue(todayDate, forKey: dateKey)
        entry1.setValue("Leg Day!", forKey: nameKey)
        entry1.setValue("Worked out for 20 min", forKey: descKey)
        entry1.setValue(-200, forKey: calKey)
        
        managedContext.save(&error)
        entries.append(entry1)
        
        //cheat day
        entry2.setValue(todayDate, forKey: dateKey)
        entry2.setValue("Cheat day", forKey: nameKey)
        entry2.setValue("Super yummy big mac", forKey: descKey)
        entry2.setValue(1000, forKey: calKey)
        
        managedContext.save(&error)
        entries.append(entry2)
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "EntryCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as EntryCell
        
        let entry = entries[indexPath.row]
        
        // Gets the date from inside core data - Adam
        var entryDate = entry.valueForKey(dateKey) as? NSDate
        
        // Formats date for display on the tableview - Adam
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        var convertedDate = dateFormatter.stringFromDate(entryDate!)
        
        // Sets the labels for each entry in entries - Adam
        cell.dateLabel.text = convertedDate
        cell.nameLabel.text = entry.valueForKey(nameKey) as? String
        cell.descriptionLabel.text = entry.valueForKey(descKey) as? String
        cell.calorieLabel.text = "\(entry.valueForKey(calKey) as Double!)"
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
