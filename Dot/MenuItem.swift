//
//  MenuItem.swift
//  Dot
//
//  Created by Titus Cheng on 11/3/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

import Foundation
import UIKit

class MenuItem:UITableViewCell
{
    @IBOutlet weak var itemLabel: UILabel!
    
    class func height() ->CGFloat {
        return 84.0
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
    //    println("My name is \(itemLabel.text)")
    }
}
