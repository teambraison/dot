//
//  MenuItem.swift
//  Dot
//
//  Created by Titus Cheng on 11/3/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

import Foundation
import UIKit

protocol MenuItemDelegate {
    func menuItemDidChooseThisMenu(menuItem: MenuItem, title:String)
    func menuItemDidBeganTouch(menuItem: MenuItem, title:String)
    func menuItemDidEndTouch(menuItem: MenuItem, title:String)
}

class MenuItem:UITableViewCell
{
    
    @IBOutlet weak var itemLabel: UILabel!
    var delegate:MenuItemDelegate?
    var viewController: UIViewController!
    var destinationController: UIViewController!
    
    class func height() ->CGFloat {
        return 90.0
    }
}
