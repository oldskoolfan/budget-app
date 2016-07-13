//
//  Account.swift
//  BudgetApp
//
//  Created by Andrew Harris on 7/12/16.
//  Copyright © 2016 AndrewFHarris. All rights reserved.
//

import UIKit

class Account {
    var accountId: Int
    var nickname: String?
    var accountType: String?
    var balance: Double?
    
    init(id: Int, name: String?, type: String?, bal: Double?) {
        accountId = id
        nickname = name
        accountType = type
        balance = bal
    }
    
    init(obj:NSDictionary) {
        accountId = obj.valueForKey("accountID") as! Int
        nickname = obj.valueForKey("nickname") as? String
        balance = obj.valueForKey("balance") as? Double
        accountType = obj.valueForKey("accountType") as? String
    }
}
