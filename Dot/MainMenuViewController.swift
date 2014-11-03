//
//  MainMenuViewController.swift
//  Dot
//
//  Created by Titus Cheng on 11/3/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

import Foundation
import UIKit

class MainMenuViewController:UIViewController, UITableViewDataSource, UITableViewDelegate
{
    
    @IBOutlet weak var menuViewController: MenuViewTable!
    
    var menuList = ["Navigation", "Messaging", "Time"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuViewController.delegate = self
        menuViewController.dataSource = self
        
        self.menuViewController.registerNib(UINib(nibName: "MenuItem", bundle: nil), forCellReuseIdentifier: "menuitem")
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: MenuItem = tableView.dequeueReusableCellWithIdentifier("menuitem") as MenuItem
        cell.itemLabel.text = menuList[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return MenuItem.height()
    }
    
//    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        return false
//    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var selectedMenu: String = menuList[indexPath.row]
        println("Did select option \(selectedMenu)")
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
//        var cells = menuViewController.visibleCells()
//        
//        let point: CGPoint = touches.anyObject()!.locationInView(self.view) as CGPoint
//        
//        println("X: \(point.x) Y: \(point.y)")
//        
//        for(var i = 0; i < cells.count; i++)
//        {
//            var tableCell: MenuItem = cells[i] as MenuItem
//            var anyPoint: UITouch = touches.anyObject() as UITouch
//            var tableCellName = tableCell.itemLabel.text
//            if(CGRectContainsPoint(tableCell.bounds, anyPoint.locationInView(tableCell))) {
//                println("Touches \(tableCellName)")
//            }
//        }
    }
    
    
}
