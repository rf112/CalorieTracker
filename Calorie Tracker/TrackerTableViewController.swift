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
    
    // For formatting dates into strins - Adam
    let dateFormatter = NSDateFormatter()
    
    // Gets today's date (I think) - Adam
    var todayDate = NSDate()
    
    var error: NSError?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        fetchEntries()
    }
    
    func fetchEntries() {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Entry")
    
        let results = managedContext?.executeFetchRequest(fetchRequest, error: &error)
        entries = results as [NSManagedObject]
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
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    */


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
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
