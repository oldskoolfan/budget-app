//
//  AccountsTableViewController.swift
//  BudgetApp
//
//  Created by Andrew Harris on 7/12/16.
//  Copyright © 2016 AndrewFHarris. All rights reserved.
//

import UIKit

class AccountsTableViewController: UITableViewController {
    
    /**
        Shows a black loading view while fetchAccounts() is waiting
     
        - Returns: Void
    */
    func showLoadingView() {
        if self.loadingView == nil {
            // load layout
            let loadingView = NSBundle.mainBundle().loadNibNamed("LoadingView", owner: self, options: nil).first as? UIView
            // set frame equal to parent view frame (for sizing)
            loadingView?.frame = self.view.frame
            // allow auto resizing
            loadingView?.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            self.loadingView = loadingView
        }
        self.view.addSubview(self.loadingView!)
    }
    
    func removeLoadingView() {
        // quickly fade out loadingView, then destroy
        UIView.animateWithDuration(0.5, animations: {
            self.loadingView?.alpha = CGFloat(0)
        }, completion: {(completion:Bool) -> Void in
            self.loadingView?.removeFromSuperview()
            self.loadingView = nil
        })
    }
    
    // MARK: - Properties
    var accounts: NSArray? = nil
    var loadingView: UIView?
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fetchAuthors()
        
        // hide empty cells with a footerView
        self.tableView.tableFooterView = UIView()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    func fetchAuthors() {
        let accounts: NSMutableArray = NSMutableArray()
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        let url = NSURL(string: "http://andrew-mbp:5000/api/accounts")
        
        // show loading view
        self.showLoadingView()
        
        if url != nil {
            let req = NSURLRequest(URL: url!)
            let task = session.dataTaskWithRequest(req) {(data, response, error) in
                dispatch_async(dispatch_get_main_queue(), {
                    print(data)
                    if data != nil {
                        do {
                            let arr = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.init(rawValue: 0)) as? NSArray
                            if arr != nil {
                                for obj in arr! {
                                    accounts.addObject(Account(obj: obj as! NSDictionary))
                                }
                                self.accounts = accounts
                                self.tableView.reloadData()
                                
                            }
                        } catch let parseError {
                            print("Error: \(parseError)")
                        }
                    }
                    self.removeLoadingView() // remove loading view
                })
            }
            task.resume()
        }
    }
    

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if self.accounts != nil {
            return self.accounts!.count
        }
        return 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let account = self.accounts?[indexPath.row] as? Account
        let cell = tableView.dequeueReusableCellWithIdentifier("account_cell", forIndexPath: indexPath)

        // Configure the cell...
        cell.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0);
        
        cell.textLabel?.text = account?.nickname
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
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
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation
    /**
        @brief Pass the selected Account model to DetailView controller
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let index = self.tableView.indexPathForSelectedRow?.row
        if index != nil {
            let account = self.accounts?.objectAtIndex(index!) as! Account
            let destController = segue.destinationViewController as! AccountDetailViewController
            destController.account = account
        }
    }
 

}
