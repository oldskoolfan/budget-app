//
//  AccountDetailViewController.swift
//  BudgetApp
//
//  Created by Andrew Harris on 7/12/16.
//  Copyright © 2016 AndrewFHarris. All rights reserved.
//

import UIKit

class AccountDetailViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var accountNameLabel: UILabel!
    @IBOutlet weak var accountTypeLabel: UILabel!
    @IBOutlet weak var accountBalanceLabel: UILabel!
    var account: Account?
    
    // MARK: - Class Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var acct: Account
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle

        if self.account != nil {
            acct = self.account!
            print("account id: \(acct.accountId)")
            accountNameLabel.text = acct.nickname
            accountTypeLabel.text = acct.accountType
            accountBalanceLabel.text = formatter.stringFromNumber(acct.balance!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
