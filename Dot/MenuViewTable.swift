//
//  MenuViewTable.swift
//  Dot
//
//  Created by Titus Cheng on 11/3/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

import Foundation
import UIKit

class MenuViewTable:DotTableView
{
    class func itemNames() -> [String] {
        return ["Navigation", "Messaging", "Time"]
    }
    
    class func itemDestinationID() -> [String] {
        return ["placeholder", "contacts", ""]
    }
    
    class func itemNibName() -> String {
        return "MenuItem"
    }
    
    class func itemID() -> String {
        return "menuitem"
    }
}
