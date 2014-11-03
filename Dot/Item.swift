//
//  Item.swift
//  Dot
//
//  Created by Titus Cheng on 11/3/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

import Foundation
import UIKit

class Item:UIView
{
    var i = 1
    override init() {
        super.init()
//        var gestureRecognizer = UIGestureRecognizer(target: self, action: Selector("didSelect"))
//        self.addGestureRecognizer(gestureRecognizer)
        
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        i++
        println("Index \(i)")
    }
    
}
