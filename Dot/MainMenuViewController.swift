//
//  MainMenuViewController.swift
//  Dot
//
//  Created by Titus Cheng on 11/3/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

import Foundation
import UIKit

class MainMenuViewController:UIViewController, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate
{
    
    @IBOutlet weak var menuViewController: MenuViewTable!
    
    let menuList = ["Navigation", "Messaging", "Time"]
    
    let destinationVCIdentifiers = ["placeholder", "contacts", ""]
    
    var placeholder = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuViewController.delegate = self
        menuViewController.dataSource = self
        menuViewController.multipleTouchEnabled = true
        self.menuViewController.registerNib(UINib(nibName: "MenuItem", bundle: nil), forCellReuseIdentifier: "menuitem")

        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: MenuItem = tableView.dequeueReusableCellWithIdentifier("menuitem") as MenuItem
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.itemLabel.text = menuList[indexPath.row]
       
        if(!destinationVCIdentifiers[indexPath.row].isEmpty) {
            let vc: UIViewController = self.storyboard?.instantiateViewControllerWithIdentifier(destinationVCIdentifiers[indexPath.row]) as UIViewController
            cell.viewController = self
            cell.destinationController = vc
        } else {
            cell.viewController = nil
            cell.destinationController = nil
        }
//        var tapGesture = UITapGestureRecognizer(target: menuViewController, action: "nextAction")
//        var holdGesture = UILongPressGestureRecognizer(target: menuViewController, action: "longPressDetected")
//        tapGesture.numberOfTapsRequired = 1
//        tapGesture.delegate = menuViewController
//        holdGesture.numberOfTouchesRequired = 1
//        holdGesture.minimumPressDuration = 0.2
//        holdGesture.delegate = menuViewController
//        cell.addGestureRecognizer(tapGesture)
//        cell.addGestureRecognizer(holdGesture)
        cell.multipleTouchEnabled = true

        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return MenuItem.height()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    
    
    
}
