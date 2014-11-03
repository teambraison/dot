//
//  MenuViewTable.swift
//  Dot
//
//  Created by Titus Cheng on 11/3/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

import Foundation
import UIKit

class MenuViewTable:UITableView
{
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        var cells = self.visibleCells()
        let point: CGPoint = touches.anyObject()!.locationInView(self) as CGPoint
        for(var i = 0; i < cells.count; i++)
        {
            var bounds = cells[i].bounds
            var item: MenuItem = cells[i] as MenuItem
            var r:CGRect = item.convertRect(item.frame, toView: nil)
            if(CGRectContainsPoint(r, point)) {
                println("Touching \(item.itemLabel.text)")
                self.selectRowAtIndexPath(NSIndexPath(forRow: i, inSection: 0), animated: false, scrollPosition: UITableViewScrollPosition.None)
            }
      //      println("\(item.itemLabel.text) has bound bound \(bounds)")
        }
    }
}
